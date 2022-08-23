census_age_gender_ggplot <- function(data, colpat1, colpat2, title, subtitle, caption, labelsize, filename, aspect_ratio = 2.5){

  # clean data
  data[data == "Women+"] <- "Women"
  data[data == "Men+"] <- "Men"
  colnames(data) <- c("age_group", "gender", "pop")

  # sort age values
  data$age_group <- factor(data$age_group, levels = str_sort(unique(data$age_group), numeric = TRUE))

  # Colour brewer color-blind safe
  colour_palette <- c(colpat1, colpat2)

  # ggplot
  ggplot(data, aes(x = age_group, y = pop, fill = gender)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.95, width = 0.85)  +
    # wideth = 1 no space between bars
    geom_text(aes(label = pop), size = labelsize, position = position_dodge(width = 0.9), vjust = 0.35, hjust = 1.05, angle = 90) +
    # vjust negative shows above bar
    theme_light() +
    theme(
      plot.title = element_text(size = rel(1.5), face = "bold", hjust = 0.5),
      plot.subtitle = element_text(size = rel(.92), hjust = 0.5),
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.position = "bottom",
      legend.title = element_blank()
    ) +
    scale_fill_manual(values = colour_palette) +
    labs(title = title,
         subtitle = subtitle,
         x = "Age Group",
         y = "Population",
         caption = caption)

  aspect_ratio <- aspect_ratio
  ggsave(filename, height = 10 , width = 4 * aspect_ratio)
}




p1 <- census_age_gender_ggplot(data = Victoria_pop_age_gender_2021_seniors,
                               colpat1 = "#af8dc3", colpat2 = "#7fbf7b",
                               title = "Victoria Seniors Population \n by Age & Gender",
                               subtitle = "(2021 Canada Census)",
                               caption = "Data: https://www12.statcan.gc.ca/census-recensement/2021",
                               labelsize = 3,
                               filename = "Victoria_pop_age_gender_2021_seniors.jpg"
)
p1

# this changes values of y axis,
# BC_pop_2021$pop <- formatC(BC_pop_2021$pop, format = "d", big.mark = ",")

p2 <- census_age_gender_ggplot(data = BC_pop_2021,
                               colpat1 = "#af8dc3", colpat2 = "#7fbf7b",
                               title = "BC Population \n by Age & Gender",
                               subtitle = "(2021 Canada Census)",
                               caption = "Data: https://www12.statcan.gc.ca/census-recensement/2021",
                               labelsize = 3,
                               filename = "BC_pop_2021.jpg"
)
p2

p3 <- census_age_gender_ggplot(data = BC_pop_2021_seniors,
                               colpat1 = "#af8dc3", colpat2 = "#7fbf7b",
                               title = "BC Seniors Population \n by Age & Gender",
                               subtitle = "(2021 Canada Census)",
                               caption = "Data: https://www12.statcan.gc.ca/census-recensement/2021",
                               labelsize = 3,
                               filename = "BC_pop_2021_seniors.jpg"
)
p3
