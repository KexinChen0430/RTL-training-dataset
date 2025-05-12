module uop_temp_out 
(
   {%-for output_name in output_lst%}
   output {{output_name}}, 
   {%-endfor%}
   input wire [7:0] A0 , 
   input wire [7:0] A1 , 
   input wire [7:0] A15, 
   input wire [7:0] B0 , 
   input wire [7:0] B15, 
   input wire [7:0] imm, 
   input wire [127:0] B, 
   input wire [127:0] A, 
   {%-for input_name in input_lst%}
   {%-if loop.last%}
   input {{input_name}} 
   {%-else%}
   input {{input_name}}, 
   {%-endif%}
   {%-endfor%}
);
{%-for wire_name in wire_lst%}
wire {{wire_name}}; 
{%-endfor%}
{%-for assign_key, assign_value in assign_dic|dictsort%}
assign {{assign_key}} = {{assign_value}}; 
{%-endfor%}
endmodule 