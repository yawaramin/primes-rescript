type handler = unit -> unit

external appendChild : _ Dom.node_like -> _ Dom.node_like -> unit = "" [@@bs.send]
external body : Dom.document -> Dom.node = "" [@@bs.get]
external createTextArea : Dom.document -> (_ [@bs.as "textarea"]) -> Dom.htmlTextAreaElement = "createElement" [@@bs.send]
external document : Dom.document = "" [@@bs.val]
external window : Dom.window = "" [@@bs.val]

external set_cols : Dom.htmlTextAreaElement -> int -> unit = "cols" [@@bs.set]
external set_readOnly : Dom.htmlTextAreaElement -> bool -> unit = "readOnly" [@@bs.set]
external set_rows : Dom.htmlTextAreaElement -> int -> unit = "rows" [@@bs.set]
external set_value : Dom.htmlTextAreaElement -> string -> unit = "value" [@@bs.set]

external set_onload : Dom.window -> handler -> unit = "onload" [@@bs.set]

let run_with_elapsed_time f =
  let start = Js.Date.(() |> make |> getTime) in
  let num = f () in
  let finish = Js.Date.(() |> make |> getTime) in
  num, (finish -. start) /. 1_000.

let is_prime num =
  if num = 2 then
    true
  else if num mod 2 = 0 then
    false
  else
    let lim = truncate ((sqrt (float_of_int num)) +. 0.5) in
    let rec lp curr =
      if curr > lim then true
      else if num mod curr = 0 then false
      else lp (curr + 2)
    in
    lp 3

let next_prime num =
  let rec lp next = if is_prime next then next else lp (next + 1) in
  lp num

let main () =
  let ta = createTextArea document in
  set_readOnly ta true;
  set_cols ta 40;
  set_rows ta 5;
  appendChild (body document) ta;

  let num, time = run_with_elapsed_time begin fun () ->
    let rec lp curr count =
      if count > 99_999 then curr
      else lp (next_prime (curr + 1)) (count + 1)
    in
    lp 1 0
  end
  in
  set_value ta {j|Elapsed time: $time
$num|j}

let () = set_onload window main

