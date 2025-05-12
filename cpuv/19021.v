module CUIdecoder_Busy1(DataBus, Name, Cmd, CmdAllowed, Info);
   input [`BYTE_range] DataBus, Cmd;
   input [8*8:1]       Name;
   input               Info;
   input               CmdAllowed;
   always @Kernel.CUIcommandEvent begin
      if ((DataBus == Cmd) && CmdAllowed) begin
         -> Kernel.VerifyEvent;
         Kernel.CommandDecode1[Cmd] = !Kernel.CommandDecode1[Cmd];
         if (Info) $display("[%t]  Command Issued: %0s",$time,Name);
      end
   end
endmodule