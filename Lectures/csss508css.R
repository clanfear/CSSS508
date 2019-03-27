csss508css <- list(
  ".hljs-tomorrow-night-bright .hljs" = list(
    "background" = "#10102c",
    "border-radius"="5px"),
  ".remark-inline-code" = list(
    "background" = "#E0E0E0",
    "color" = "#10102c",
    "border-radius" = "3px",
    "padding" = "2px"),
  ".inverse .remark-inline-code" = list(
    "background" = "#10102c",
    "color" = "#ececf8",
    "border-radius" = "3px",
    "padding" = "2px"),
  ".smallish" = list("font-size" = "85%"),
  ".small" = list("font-size" = "75%"),
  ".smaller" = list("font-size" = "60%"),
  ".remark-code-line-highlighted" = list(
    "background-color" = "rgba(255,0,255,0.2)"),
  "sup" = list("font-size" = "14px"),
  "h1, h2, h3" = list(
    "margin-top"=".25em", 
    "margin-bottom"=".25em"),
  ".pull-left60" = list(
    "float" = "left",
    "width" = "60%" ),
  ".pull-right40" = list(
    "float" = "right",
    "width" = "40%" ),
  ".pull-left40" = list(
    "float" = "left",
    "width" = "40%" ),
  ".pull-right60" = list(
    "float" = "right",
    "width" = "60%" ),
  ".bottom" = list(
    "position"="absolute",
    "bottom"="0",
    "left"="0"),
  "a" = list("text-decoration" = "underline"),
  ".inverse a" = list("color" = "#cbd3a3"),
  "body" = list("line-height" = "1.4"),
  ".inverse" = list("background-image" = "url(https://clanfear.github.io/CSSS508/Lectures/img/UWCSSSBG1_white.svg)"),
  ".short" = list("height" = "30%"),
  ".image-50 img" = list("width" = "50%"),
  ".image-75 img" = list("width" = "75%"),
  ".image-full img" = list(
    "height" = "480px",
    "display"="block",
    "margin-left"="auto",
    "margin-right"="auto"),
  ".title-slide" = list("background-image" = "url(https://clanfear.github.io/CSSS508/Lectures/img/UWCSSSBG1_white.svg), url(https://clanfear.github.io/CSSS508/Lectures/img/title_slide_img.png)",
                        "background-position" = "center center, center bottom",
                        "background-size" = "contain, contain")
)
mono_accent(base_color = "#342c5c",
            code_font_google = google_font("Fira Mono"),
            header_font_google = google_font("Quattrocento"),
            extra_css = csss508css,
            title_slide_background_image = "https://raw.githubusercontent.com/clanfear/CSSS508/master/Lectures/img/title_slide_img.png",
            title_slide_background_position = "bottom",
            title_slide_background_size = "contain",
            background_image = "https://clanfear.github.io/CSSS508/Lectures/img/UWCSSSBG1.svg"
)