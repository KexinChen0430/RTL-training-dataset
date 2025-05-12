module CUIdecoder1(DataBus,Name,Cmd,CmdAllowed,Info);
   input [`BYTE_range] DataBus, Cmd; 
   input [8*35:1]      Name;         
   input               Info;         
   input               CmdAllowed;   
   always @Kernel.CUIcommandEvent begin
      #1; 
      if (DataBus == Cmd  && CmdAllowed) begin  
         #1 -> Kernel.VerifyEvent; 
         Kernel.CommandDecode1[Cmd] = !Kernel.CommandDecode1[Cmd];
         if (Info) $display("[%t]  Command Issued: %0s",$time,Name);
      end
      else begin
         if (`FALSE) $display("[%t]  The %0s instruction decode unit is waiting for operation to complete.",$time,Name);
         @(Kernel.CompleteEvent or Kernel.ErrorEvent)
            if (`FALSE) $display("[%t]  The %0s instruction decode unit is listening for next command.",$time,Name);
      end
   end
endmodule