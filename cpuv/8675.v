module ceespu_writeback (
  input I_clk, 
  input I_rst, 
  input [1:0] I_selWb, 
  input [2:0] I_selMem, 
  input [13:0] I_PC, 
  input [31:0] I_aluResult, 
  input [31:0] I_dmemData, 
  output reg [31:0] O_writeData 
);
always @(*) begin
  if (I_selWb == 2'b00) begin
    O_writeData = I_aluResult; 
  end
  else if (I_selWb == 2'b01) begin
    if (I_selMem == 3'd0) begin
      O_writeData = I_dmemData; 
    end
    else if (I_selMem == 3'd1) begin
      O_writeData = (I_aluResult[1]) ? {{16{I_dmemData[31]}}, I_dmemData[31:16]} : {{16{I_dmemData[15]}}, I_dmemData[15:0]};
    end
    else if (I_selMem == 3'd2) begin
      case ( I_aluResult[1:0] )
        0: O_writeData = {{24{I_dmemData[7]}}, I_dmemData[7:0]};
        1: O_writeData = {{24{I_dmemData[15]}}, I_dmemData[15:8]};
        2: O_writeData = {{24{I_dmemData[23]}}, I_dmemData[23:16]};
        3: O_writeData = {{24{I_dmemData[31]}} , I_dmemData[31:24]};
      endcase
    end
    else if (I_selMem == 3'd3) begin
      O_writeData = (I_aluResult[1]) ? I_dmemData[31:16] : I_dmemData[15:0];
    end
    else begin
      case ( I_aluResult[1:0] )
        0: O_writeData = I_dmemData[7:0];
        1: O_writeData = I_dmemData[15:8];
        2: O_writeData = I_dmemData[23:16];
        3: O_writeData = I_dmemData[31:24];
      endcase
    end
  end
  else begin
    O_writeData = (I_PC << 2); 
    $display("call c19 = %d", I_PC); 
  end
end
endmodule