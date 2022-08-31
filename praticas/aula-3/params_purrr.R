
library(quarto)

caminho_qmd <- "praticas/aula-2/pratica-aula-2.qmd"

quarto_render(
  caminho_qmd,
  execute_params = list(estado = "CE"),
  output_file = "praticas/aula-2/CE.html",
  quiet = TRUE
)

sigbm <- readxl::read_excel("praticas/aula-2/dados/sigbm.xlsx", skip = 4)

sigbm$UF

estados_no_sigbm <- sort(unique(sigbm$UF))

## mas isso aqui não é tão divertido...
# for (estado in estados_no_sigbm) {
#
# }


# purrr!!!! ---------------------------------------------------------------

library(purrr)

sqrt(1)
sqrt(2)
sqrt(3)

raizes <- c()
for (i in 1:3) {
  raizes[i] <- sqrt(i)
}

map(1:3, sqrt)

map(1:3, ~ .x ^ 3)

# resumindo

map(
  vetor_que_quero_iterar, # -> estados_no_sigbm
  funcao_de_iteracao # -> quarto_render...
)

## obs: glue

nome <- "jubs"

glue::glue("Meu nome é {nome}")

# rstudioapi::job
map(
  estados_no_sigbm,
  ~quarto_render(
    caminho_qmd,
    execute_params = list(estado = .x),
    output_file = glue::glue("praticas/aula-2/{.x}.html"),
    quiet = TRUE,
    as_job = TRUE
  )
)


map(
  estados_no_sigbm,
  ~quarto_render(
    caminho_qmd,
    output_format = "docx",
    execute_params = list(estado = .x),
    output_file = glue::glue("praticas/aula-2/{.x}.docx"),
    quiet = TRUE#,
    # as_job = TRUE
  )
)

## função walk: roda o código, mas não retorna nada
walk(
  1:3,
  ~print(sqrt(.x))
)

walk(
  estados_no_sigbm,
  ~quarto_render(
    "pratica-aula-2.qmd",
    output_format = "docx",
    execute_params = list(estado = .x),
    output_file = glue::glue("{.x}.docx"),
    quiet = TRUE#,
    # as_job = TRUE
  )
)
