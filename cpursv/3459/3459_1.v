
module regbank(addr1,addr2,addrdest,data1,data2,datadest,control,enable);

  input  wire [2:0] addr1,addr2,addrdest,datadest;
  output wire [7:0] data1,data2;
  input  wire [2:0] control;
  input  wire enable;
  reg  [7:0] r0,r1,r2,r3,r4,r5,r6,r7;

  
  always @(posedge enable)
      begin
        if (control[0]) 
          begin
            case (addr1)

              0: data1 = r0;

              1: data1 = r1;

              2: data1 = r2;

              3: data1 = r3;

              4: data1 = r4;

              5: data1 = r5;

              6: data1 = r6;

              default: data1 = r7;

            endcase

          end
          
        if (control[1]) 
          begin
            case (addr2)

              0: data2 = r0;

              1: data2 = r1;

              2: data2 = r2;

              3: data2 = r3;

              4: data2 = r4;

              5: data2 = r5;

              6: data2 = r6;

              default: data2 = r7;

            endcase

          end
          
        if (control[2]) 
          begin
            case (addrdest)

              0: r0 = datadest;

              1: r1 = datadest;

              2: r2 = datadest;

              3: r3 = datadest;

              4: r4 = datadest;

              5: r5 = datadest;

              6: r6 = datadest;

              default: r7 = datadest;

            endcase

          end
          
      end
endmodule

