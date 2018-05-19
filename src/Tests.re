
let inputs = [
{|
  * Hello
  * Folks
|},
{| Hello
 * Folks
|},
{|Hello
 * Folks
|},
];

inputs |> List.iter(f => {
  print_endline("====");
  print_endline(f);
  print_endline("----");
  print_endline(PrepareUtils.cleanOffStars(f))
});
