module acts (input, address, syn_in, syn_out, out, ack, ack_syn); 
   input [7:0] input; 
   input [7:0] address; 
   input syn_in; 
   output reg [7:0] syn_out; 
   output reg [7:0] out; 
   output reg ack; 
   output reg ack_syn; 
   reg [7:0] reg_input; 
   reg [7:0] reg_out_syn; 
   always @(input or address or syn_in) 
   begin
      if (syn_in) 
      begin
         reg_input = input; 
         reg_out_syn = address; 
         ack_syn = 1; 
      end
      else 
      begin
         out = reg_input; 
         syn_out = reg_out_syn; 
         ack = 1; 
      end
   end
   initial 
   begin
      if (ack && ack_syn) 
      begin
         $display("The module acts different"); 
         $display("Input data: %h, address: %h, syn_out: %h, out: %h, ack: %b, ack_syn: %b", reg_input, address, reg_out_syn, reg_out, ack, ack_syn); 
         $stop; 
      end
   end
endmodule 