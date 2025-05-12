
module SingleCycleProcessor(output reg [31:0] PC,
                            output reg [31:0] datain,
                            output reg [31:0] address,
                            output reg MW,
                            input  [31:0] instruction,
                            input  [31:0] dataout,
                            input  clk,
                            input  reset_n);

  reg  [31:0] nextPC,counter,nextReg,seIM,zfIM;
  reg  [31:0] R[0:31];
  reg  RW;
  wire [14:0] IM;
  wire [4:0] AA,BA,DA;
  wire [6:0] op;
  wire [3:0] FS;
  parameter  NOP = 7'b0000000;
  parameter  MOVA = 7'b1000000;
  parameter  JML = 7'b0110000;
  integer i;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            counter <= 0;
            PC <= 0;
            for (i = 0; i < 32; i = i+1)
                begin
                  R[i] = 0;
                end
          end
        else 
          begin
            if (counter == 0) 
              begin
                counter <= counter+1;
                PC <= nextPC;
              end
            else 
              begin
                counter <= 0;
                PC <= nextPC;
                if ((DA != 0) && (RW == 1'b1)) 
                  begin
                    R[DA] = nextReg;
                  end
                  
              end
          end
      end
  assign AA = instruction[19:15];
  assign BA = instruction[14:10];
  assign DA = instruction[24:20];
  assign op = instruction[31:25];
  assign IM = instruction[14:0];
  
  always @(*)
      begin
        if (IM[14] == 1'b0) 
          begin
            seIM = {17'd0,IM};
            zfIM = {17'd0,IM};
          end
        else 
          begin
            seIM = {17'd1,IM};
            zfIM = {17'd0,IM};
          end
      end
  
  always @(*)
      begin
        RW = 1'b0;
        MW = 1'b1;
        nextReg = 0;
        address = 0;
        datain = 0;
        if (counter == 1) 
          begin
            case (op)

              default: begin
                    nextPC = 1+PC;
                  end

            endcase

          end
        else 
          begin
            if (op == LD) 
              begin
                address = R[AA];
                MW = 1'b1;
              end
              
            nextPC = PC;
          end
      end
endmodule

