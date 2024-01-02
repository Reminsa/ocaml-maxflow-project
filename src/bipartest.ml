

open Gfile
open Tools 
open Fordfulkerson
open Bipartit
open Graph

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 4 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile_biparti = Sys.argv.(2)
  and outfiledot_biparti = Sys.argv.(3)


  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Read_file test and export initial graph *)
  let graph = read_file infile in
  let graphstring = gmap graph string_of_int in 
  let () = write_file outfile_biparti graphstring in
  let () = export outfiledot_biparti graphstring in

  

  ()