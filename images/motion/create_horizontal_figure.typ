// 画像生成方法
// ```sh
// typst compile create_horizontal_figure.typ -f png "horizontal-{n}.png"
// ```

#set page(width: auto, height: auto, margin: 15pt)
#show raw: set text(font: "CommitMono-height105", size: 12pt)
#set text(font: "CommitMono-height105", size: 12pt)

#let _wrap_zerowidth_space(s) = {
  if s.starts-with(regex("\\s")) {
    s = "​" + s
  }
  if s.ends-with(regex("\\s")) {
    s = s + "​"
  }
  s
}

#let with_idx_hl(
  w: none,
  b: none,
  body
) = {
  let stroke_width = 0.5pt
  let content = for (idx, char) in body.clusters().enumerate() {
    if idx == b {
      box(
        fill: black, outset: (y: 3pt),
        text(fill: white, _wrap_zerowidth_space(char))
      )
    } else if idx == w {
      box(
        stroke: stroke_width, outset: (y: 3pt - stroke_width / 2,),
        _wrap_zerowidth_space(char)
      )
    } else {
      raw(char)
    }
  }
  box(
    fill: luma(95%),
    outset: (y: 3pt, x: 2pt),
    radius: 2pt,
    content
  )
}

#import "@preview/cetz:0.2.1"

#let draw_cursor_moves(name: "", init: 0, moves: ()) = {
  context{
    let unit = measure[`i`].width

    cetz.canvas(
      debug: false,
      length: unit,
      {
        import cetz.draw: *

        if name == "" {
          content((-4, 0), [], anchor: "south-west")
        } else {
          content(
            (-4, 0),
            box(fill: luma(80%), outset: (x: 2pt, y: 4pt), radius: 2pt, name),
            anchor: "south-west",
          )
        }
        for (idx, move) in moves.enumerate() {
          content(
            (0, - idx * 3),
            with_idx_hl(b: move, w: init, `if type(first_arg) == "number" then`.text),
            anchor: "south-west",
          )
        }
      },
    )
  }
}

#page(draw_cursor_moves(init: 10, moves: (10,)))
#page(draw_cursor_moves(name: "h", init: 10, moves: (9, 8, 7)))
#page(draw_cursor_moves(name: "l", init: 10, moves: (11, 12, 13)))
#page(draw_cursor_moves(name: "w", init: 10, moves: (17, 19, 22)))
#page(draw_cursor_moves(name: "e", init: 10, moves: (16, 17, 20)))
#page(draw_cursor_moves(name: "b", init: 10, moves: (8, 7, 3)))
#page(draw_cursor_moves(name: "W", init: 10, moves: (19, 22, 31)))
#page(draw_cursor_moves(name: "E", init: 10, moves: (17, 20, 29)))
#page(draw_cursor_moves(name: "B", init: 10, moves: (3, 0)))
#page({
  draw_cursor_moves(name: "f)", init: 10, moves: (17,))
  draw_cursor_moves(name: "f\"", init: 10, moves: (22, 29))
})
#page({
  draw_cursor_moves(name: "t)", init: 10, moves: (16,))
  draw_cursor_moves(name: "t\"", init: 10, moves: (21,))
})
#page(draw_cursor_moves(name: "^", init: 10, moves: (0,)))
#page(draw_cursor_moves(name: "$", init: 10, moves: (34,)))
