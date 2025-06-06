
module synthetic_op(clk,sel,opa32,opb32,res64);

  input  clk;
  input  [2:0] sel;
  input  [31:0] opa32,opb32;
  output [63:0] res64;
  wire signed  [31:0] sopa32,sopb32;
  wire [31:0] uopa32,uopb32;
  wire [31:0] aopa32,aopb32;
  wire [63:0] out_abs;
  reg  [47:0] unsign_st1a,unsign_st1b;
  reg  [2:0] pipe1,pipe2;
  reg  [31:0] pipea,pipeb;

  assign sopa32 = (sel[1:0] == 2'b10) ? opa32 : 
                  (sel[1:0] == 2'b01) ? {{16{opa32[15]}},opa32[15:0]} : {{24{opa32[7]}},opa32[7:0]};
  assign sopb32 = (sel[1:0] == 2'b10) ? opb32 : 
                  (sel[1:0] == 2'b01) ? {{16{opb32[15]}},opb32[15:0]} : {{24{opb32[7]}},opb32[7:0]};
  assign uopa32 = (sel[1:0] == 2'b10) ? opa32 : 
                  (sel[1:0] == 2'b01) ? {16'b0,opa32[15:0]} : {24'b0,opa32[7:0]};
  assign uopb32 = (sel[1:0] == 2'b10) ? opb32 : 
                  (sel[1:0] == 2'b01) ? {16'b0,opb32[15:0]} : {24'b0,opb32[7:0]};
  assign aopa32 = ({sel[2],sopa32[31]} == 2'b11) ? (1+~sopa32) : uopa32;
  assign aopb32 = ({sel[2],sopb32[31]} == 2'b11) ? (~sopb32+1) : uopb32;
  
  always @(posedge clk)
      begin
        pipea <= aopa32;
        pipeb <= aopb32;
        pipe1 <= {sel[2],sopa32[31],sopb32[31]};
      end
  
  always @(posedge clk)
      begin
        unsign_st1a <= pipeb[15:0]*pipea;
        unsign_st1b <= pipea*pipeb[31:16];
        pipe2 <= pipe1;
      end
  assign out_abs = {unsign_st1b,16'b0}+{16'b0,unsign_st1a};
  assign res64 = ((pipe2 == 3'b101) || (pipe2 == 3'b110)) ? (~out_abs+1) : out_abs;
endmodule

