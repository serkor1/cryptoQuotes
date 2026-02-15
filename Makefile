## Package information
package_name     := $(shell grep "^Package:" DESCRIPTION | sed "s/Package: //")
package_version  := $(shell grep "^Version:" DESCRIPTION | sed "s/Version: //")
tarball_location := $(package_name)_$(package_version).tar.gz

## default target
.PHONY: help
help:
	@grep -h -E '^[[:space:]]*[A-Za-z0-9_.-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sed -E 's/^[[:space:]]*//' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;34m%-15s\033[m \xE2\x80\x94 %s\n", $$1, $$2}'

build: ## Build the R package
	@Rscript --verbose -e "devtools::document()"
	@R CMD build . && R CMD INSTALL $(tarball_location)
	@Rscript -e "rmarkdown::render('README.Rmd', output_format = rmarkdown::github_document(html_preview = FALSE), clean = TRUE)"
	@Rscript -e "rmarkdown::render('NEWS.Rmd', output_format = rmarkdown::github_document(html_preview = FALSE), clean = TRUE)"

check: ## Check the R package
	@Rscript --verbose -e "devtools::document()"
	@R CMD build . && R CMD check $(tarball_location)

test: ## Run tests
	@Rscript --verbose -e "Sys.setenv(NOT_CRAN = 'true'); library(cryptoQuotes); testthat::test_dir('tests/testthat')"

clean: ## Remove artifacts
	@rm -rf $(tarball_location)
	@rm -rf $(package_name).Rcheck
	@Rscript -e "remove.packages('$(package_name)')"

fmt: ## Format code
	@air format .

pkgdown-build: ## Build {pkgdown} documentation
	@Rscript --verbose -e "devtools::document()"
	@Rscript -e "pkgdown::clean_site()"
	@Rscript -e "pkgdown::init_site()"
	@Rscript -e "pkgdown::build_site()"

pkgdown-preview: ## Preview {pkgdown} documetation
	@Rscript -e "pkgdown::preview_site()"