#' Create D3plus charts in R
#'
#' A function to initialize a D3plus chart in R
#'
#' @param data a data.frame object to create the visualization.
#' @param type a name indicating the type of the chart.
#' @param id a vector with the id's column names.
#' @param currency a name indicating the currency symbol (US$, R$, etc.).
#' @param number_text a name to show after the number. Example: c("K", "M", "M", "B", "B").
#' @param currency_var a vector with variable names to apply the currency format.
#' @param noformat_number_var a vector variables names to not apply any formatting. 
#' @param percent_var a vector with variable names to apply the share format.
#' @param d3plus_number_format a logical indicating if the d3plus.number.format should be applied to numbers.
#' @param locale a name indicating the language to be used
#' @param dictionary a named list. The element's name should be the original text and the value should be the new text.
#' @param width a number (in pixels) or percent text ("100\%") indicating the visualization's width.
#' @param height a number (in pixels) or percent text ("100\%") indicating the visualization's height.
#' @param elementId a name for the visualization's id.
#' @param clean_previous a logical indicating whether the visualization is restarted after input update (only for shiny).
#'
#' @import htmlwidgets
#' @import jsonlite
#'
#' @export
#' 
#' @examples 
#' 
#' 

d3plus <- function(data = NULL,
                   type = c("tree_map", "bar", "line", "scatter", "geo_map",
                            "stacked", "radar", "sankey", "rings", "network",
                            "box", "bubbles"),
                   id = NULL, currency = "US$", number_text = c("K", "M", "M", "B", "B"),
                   currency_var = NULL, percent_var = NULL, noformat_number_var = NULL,
                   d3plus_number_format = TRUE,
                   locale = "en_US", dictionary = NULL, width = NULL,
                   height = NULL, elementId = NULL,
                   clean_previous = FALSE) {
  
  
  settings = list(
    type = type,
    id = jsonlite::toJSON(id),
    title = title,
    currency = currency,
    number_text = number_text,
    currency_var = currency_var,
    percent_var = percent_var,
    noformat_number_var = noformat_number_var,
    d3plus_number_format = d3plus_number_format,
    locale = locale,
    clean_previous = clean_previous,
    dictionary = jsonlite::toJSON(dictionary, auto_unbox = T)
  )
  # forward options using x
  x = list(
    data = jsonlite::toJSON(data, auto_unbox = T),
    settings = settings
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'd3plus',
    x,
    width = width,
    height = height,
    package = 'D3plusR',
    elementId = elementId
  )
}

#' Shiny bindings for d3plus
#'
#' Output and render functions for using d3plus within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a d3plus
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name d3plus-shiny
#'
#' @export
d3plusOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'd3plus', width, height, package = 'D3plusR')
}

#' @rdname d3plus-shiny
#' @export
renderD3plus <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, d3plusOutput, env, quoted = TRUE)
}
