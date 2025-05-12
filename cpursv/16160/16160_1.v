
module inputs(validdata,wZa,wZb,wCa,wCb,wNa,wNb,wInstruction);

  output reg wZa,wZb,wCa,wCb,wNa,wNb;
  output reg [7:0] validdata;
  output reg [15:0] wInstruction;

  
  initial  
  begin
    #10 
      validdata = 8'd8;
      wZa = 0;
      wZb = 0;
      wCa = 1;
      wCb = 0;
      wNa = 0;
      wNb = 0;
      wInstruction = 15'd0;

    #500 
      validdata = 8'd8;
      wZa = 1;
      wZb = 0;
      wCa = 0;
      wCb = 0;
      wNa = 0;
      wNb = 0;
      wInstruction = 15'd0;

    #1000 
      validdata = 8'd16;
      wZa = 0;
      wZb = 0;
      wCa = 1;
      wCb = 0;
      wNa = 0;
      wNb = 0;
      wInstruction = 15'd0;

    #1500 
      validdata = 8'd16;
      wZa = 0;
      wZb = 1;
      wCa = 0;
      wCb = 0;
      wNa = 0;
      wNb = 0;
      wInstruction = 15'd0;

    #2000 
      validdata = 8'd32;
      wZa = 0;
      wZb = 0;
      wCa = 1;
      wCb = 1;
      wNa = 1;
      wNb = 0;
      wInstruction = 15'd0;

    #2500 
      validdata = 8'd32;
      wZa = 1;
      wZb = 0;
      wCa = 0;
      wCb = 1;
      wNa = 1;
      wNb = 0;
      wInstruction = 15'd0;

    #3000 
      validdata = 8'd64;
      wZa = 0;
      wZb = 0;
      wCa = 1;
      wCb = 1;
      wNa = 1;
      wNb = 0;
      wInstruction = 15'd0;

    #3500 
      validdata = 8'd64;
      wZa = 0;
      wZb = 1;
      wCa = 0;
      wCb = 1;
      wNa = 1;
      wNb = 0;
      wInstruction = 15'd0;

  end
endmodule

