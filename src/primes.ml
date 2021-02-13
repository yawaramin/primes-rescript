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

let () =
  let rec lp curr count =
    if count > 99_999 then curr
    else lp (next_prime (curr + 1)) (count + 1)
  in
  Js.log (lp 1 0)

