window.onresize = function() {
  var allPlotlyCharts = document.querySelectorAll('.js-plotly-plot');

  allPlotlyCharts.forEach(function(chart) {
    Plotly.relayout(chart, {
      width: chart.offsetWidth,
      // Optionally adjust height as well
    });
  });
};
