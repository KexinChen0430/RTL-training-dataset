
module Coprocessor0(input  clk,
                    input  [4:0] C0adr,
                    input  [31:0] C0Wdata,
                    input  C0Write,
                    input  [31:0] InteCause,
                    input  Interrupt,
                    output InteAccept,
                    output [31:0] C0State,
                    output reg [31:0] C0Data);

  parameter  EPCadr = 5'h0;
  parameter  Causeadr = 5'h1;
  parameter  Stateadr = 5'h2;
  reg  [31:0] EPC;
  reg  [31:0] Cause;
  reg  [31:0] State;

  
  initial  
  begin
    State <= 32'h1;
    Cause <= 32'h0;
    EPC <= 32'h0;
  end
  assign C0State = State;
  assign InteAccept = 
(~(C0Write && (C0adr == Stateadr)) || 
(~State[1] && 
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt && 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write))) || 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write) && 
(Interrupt && (C0Write && (C0adr == Stateadr)) && 
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt) || ~C0Wdata[1]))))) || 
(
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt && 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write))) || 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write) && 
(Interrupt && (C0Write && (C0adr == Stateadr)) && 
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt) || ~C0Wdata[1])))) && 
(
(((C0adr == Stateadr) && (~C0Wdata[1] && C0Write)) || 
~State[1]) && Interrupt))) && 
                      (
(~((C0adr == Causeadr) && C0Write) && ~State[1] && 
Interrupt) || 
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt && 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write))) || 
((C0adr == Stateadr) && (~C0Wdata[1] && C0Write) && 
(Interrupt && (C0Write && (C0adr == Stateadr)) && 
(
(~(C0Write && (C0adr == Stateadr)) && 
~((C0adr == Causeadr) && C0Write) && Interrupt) || ~C0Wdata[1])))));
  
  always @(posedge clk)
      begin
        if (C0Write) 
          begin
            if (C0adr == EPCadr) 
              begin
                EPC <= C0Wdata;
                if (~State[1] && Interrupt) 
                  begin
                    State <= State | 32'b10;
                    Cause <= InteCause;
                  end
                  
              end
              
            if (C0adr == Stateadr) 
              begin
                if (~C0Wdata[1] && Interrupt) 
                  begin
                    State <= 32'b10 | C0Wdata;
                    Cause <= InteCause;
                  end
                else 
                  begin
                    State <= C0Wdata;
                  end
              end
              
            if (C0adr == Causeadr) 
              begin
                Cause <= C0Wdata;
              end
              
          end
        else 
          begin
            if (~State[1] && Interrupt) 
              begin
                State <= State | 32'b10;
                Cause <= InteCause;
              end
              
          end
        case (C0adr)

          EPCadr: begin
                C0Data <= EPC;
              end

          Causeadr: begin
                C0Data <= Cause;
              end

          Stateadr: begin
                C0Data <= State;
              end

        endcase

      end
endmodule

