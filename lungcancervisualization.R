library(teal)
library(teal.modules.general)

app <- init(
  data = teal_data("Lung Cancer" = read.csv("lungcancerdata.csv")),
  modules = modules(
    tm_data_table(
      label = "Data Table",
      variables_selected = list(),
      datanames = "Lung Cancer",
      dt_args = list(),
      dt_options = list(searching = FALSE, pageLength = 50, lengthMenu = c(18), scrollx = TRUE),
      server_rendering = FALSE,
      transformators = list()
    ),
    tm_g_distribution(
      dist_var = data_extract_spec(
        dataname = "Lung Cancer",
 #       select = select_spec(variable_choices("Lung Cancer"), "Lung.Cancer")
        select = select_spec("Lung.Cancer")
      )
    ),
   tm_g_scatterplot(
     label = "Scatterplot",
     x = data_extract_spec(
       dataname = "Lung Cancer",
       select = select_spec(
          choices = c("PM2.5", "Land_EQI", "Sociod_EQI", "Built_EQI", "PM10", "SO2", "NO2", "O3", "CO", "CN", "Disel", "CS2", "Air_EQI", "Water_EQI", "EQI"),
          selected = c("PM2.5"),
          multiple = FALSE,
          fixed = FALSE,
          label = "Column"
       )
     ),
     y = data_extract_spec(
       dataname = "Lung Cancer",
       select = select_spec("Lung.Cancer")
     ),
     color_by = NULL,
     size_by = NULL,
     row_facet = NULL,
     col_facet = NULL,
     plot_height = c(600, 200, 2000),
     plot_width = NULL,
     alpha = c(1, 0, 1),
     size = c(5, 1, 15),
     max_deg = 5L,
     rotate_xaxis_labels = FALSE,
     ggtheme = c("gray", "bw", "linedraw", "light", "dark", "minimal", "classic", "void"),
     ggplot2_args = teal.widgets::ggplot2_args()
   )
  ),
  filter = teal_slices(
    teal_slice(dataname = "Lung Cancer", varname = "State", multiple = TRUE),
    teal_slice(dataname = "Lung Cancer", varname = "Lung.Cancer", multiple = TRUE)
  )
) |>
  
  modify_title("DASHBOARD") |>
  modify_header(h3("LUNG CANCER DASHBOARD")) |>
  modify_footer("Hello World")

shinyApp(app$ui, app$server)