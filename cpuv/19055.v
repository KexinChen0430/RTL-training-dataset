module CUIdecoder2(DataBus,Name,Cmd1,Cmd2,CmdAllowed,Info);
   input [`BYTE_range] DataBus, Cmd1, Cmd2; 
   input [8*27:1]      Name; 
   input               Info; 
   input               CmdAllowed; 
   always @Kernel.CUIcommandEvent begin
      if (DataBus == Cmd1 && CmdAllowed) begin
         #1 -> Kernel.VerifyEvent; 
         @Kernel.CUIcommandEvent 
         if (DataBus == Cmd2 && CmdAllowed)  begin
            #1  -> Kernel.VerifyEvent; 
            Kernel.CommandDecode2[{Cmd1,Cmd2}] = !Kernel.CommandDecode2[{Cmd1,Cmd2}];
            if (Info) $display("[%t]  Command Issued: %0s",$time,Name);
         end
      end
      else begin
         if (`FALSE) $display("%t  The %0s instruction decode unit is waiting for operation to complete.",$time,Name);
         @(Kernel.CompleteEvent or Kernel.ErrorEvent)
         if (`FALSE) $display("%t  The %0s instruction decode unit is listening for next command",$time,Name);
      end
   end
endmodule