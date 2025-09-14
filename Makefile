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
	@tools/generate_API.sh src/ src/api.h && tools/generate_FFI.sh src/api.h src/init.c && $(MAKE) fmt
	@Rscript --verbose -e "devtools::document()"
	@R CMD build . && R CMD INSTALL $(tarball_location)
	@Rscript -e "rmarkdown::render('README.Rmd', output_format = rmarkdown::github_document(html_preview = FALSE), clean = TRUE)"

check: ## Check the R package
	@Rscript --verbose -e "devtools::document()"
	@R CMD build . && R CMD check $(tarball_location)

test: ## Run tests
	@Rscript --verbose -e "library(talib); testthat::test_dir('tests/testthat')"

clean: ## Remove artifacts
	@rm -rf $(tarball_location)
	@rm -rf $(package_name).Rcheck
	@Rscript -e "remove.packages('$(package_name)')"

fmt: ## Format code
	@air format .