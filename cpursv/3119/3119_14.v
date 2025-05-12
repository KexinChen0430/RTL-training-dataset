
module InterruptCtrl(input  [1:0] io_inputs,
                     input  [1:0] io_clears,
                     input  [1:0] io_masks,
                     output [1:0] io_pendings,
                     input  io_mainClk,
                     input  resetCtrl_systemReset);

  reg  [1:0] pendings;

  assign io_pendings = ((io_masks | ((pendings & ~io_clears) & io_inputs)) & pendings) & ((pendings | ~io_clears) & io_masks);
  
  always @(posedge io_mainClk or posedge resetCtrl_systemReset)
      begin
        if (resetCtrl_systemReset) 
          begin
            pendings <= 2'b00;
          end
        else 
          begin
            pendings <= (((io_inputs | ~io_clears) & pendings) | ((pendings & ~io_clears) | (~io_clears & io_inputs))) | io_inputs;
          end
      end
endmodule

