
module register(data1,data2,data4,data5,data7,data8,data10,data11,data3,
                data6,data9,data12,data13,reg_number1,reg_number2,reg_number3,
                reg_number4,reg_number5,reg_number6,reg_number7,reg_number8,
                reg_number9,reg_number10,reg_number11,reg_number12,
                reg_number13,read1,read2,read4,read5,read7,read8,read10,
                read11,write3,write6,write9,write12,write13);

  output [31:0] data1,data2,data4,data5,data7,data8,data10,data11;
  input  [31:0] data3,data6,data9,data12,data13;
  input  [4:0] 
      reg_number1 ,
      reg_number2 ,
      reg_number3 ,
      reg_number4 ,
      reg_number5 ,
      reg_number6 ,
      reg_number7 ,
      reg_number8 ,
      reg_number9 ,
      reg_number10,
      reg_number11,
      reg_number12,
      reg_number13;
  input  read1,read2,read4,read5,read7,read8,read10,read11;
  input  write3,write6,write9,write12,write13;
  reg  signed  [31:0] register[31:0];

  assign data1 = read1 ? register[reg_number1] : 32'hz;
  assign data2 = read2 ? register[reg_number2] : 32'hz;
  assign data4 = read4 ? register[reg_number4] : 32'hz;
  assign data5 = read5 ? register[reg_number5] : 32'hz;
  assign data7 = read7 ? register[reg_number7] : 32'hz;
  assign data8 = read8 ? register[reg_number8] : 32'hz;
  assign data10 = read10 ? register[reg_number10] : 32'hz;
  assign data11 = read11 ? register[reg_number11] : 32'hz;
  
  always @(posedge write3)  begin

  end
  
  always @(posedge write6)  begin

  end
  
  always @(posedge write9)  begin

  end
  
  always @(posedge write12)  begin

  end
  
  always @(posedge write13)  begin

  end
endmodule

