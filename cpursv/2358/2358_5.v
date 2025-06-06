
module memory(gm_or_lds,rd_en,wr_en,addresses,wr_data,input_tag,rd_data,
              output_tag,ack,clk,rst);

  input  clk;
  input  rst;
  input  gm_or_lds;
  input  rd_en,wr_en;
  input  [31:0] addresses;
  input  [31:0] wr_data;
  input  [6:0] input_tag;
  output [6:0] output_tag;
  output ack;
  output [31:0] rd_data;
  reg  [7:0] data_memory[50000:0];
  reg  [7:0] lds_memory[65535:0];
  reg  ack_reg;
  reg  [6:0] tag_reg;

  assign ack = ack_reg;
  assign output_tag = tag_reg;
  integer i;

  
  always @(posedge clk or posedge rst)
      begin
        if (wr_en) 
          begin
            if (gm_or_lds) 
              begin
                lds_memory[addresses] <= wr_data[7:0];
                lds_memory[addresses+1] <= wr_data[15:7];
                lds_memory[2+addresses] <= wr_data[23:16];
                lds_memory[3+addresses] <= wr_data[31:24];
              end
            else 
              begin
                data_memory[addresses] <= wr_data[7:0];
                data_memory[addresses+1] <= wr_data[15:7];
                data_memory[2+addresses] <= wr_data[23:16];
                data_memory[3+addresses] <= wr_data[31:24];
              end
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            ack_reg <= 1'b0;
            tag_reg <= 7'd0;
          end
        else 
          begin
            ack_reg <= 1'b0;
            tag_reg <= 7'd0;
            if (rd_en | wr_en) 
              begin
                ack_reg <= 1'b1;
                tag_reg <= input_tag;
              end
              
          end
      end
  wire [31:0] rd_lds;

  wire [31:0] rd_dm;

  assign rd_lds = {lds_memory[3+addresses],lds_memory[2+addresses],lds_memory[addresses+1],lds_memory[addresses]};
  assign rd_dm = {data_memory[3+addresses],data_memory[2+addresses],data_memory[addresses+1],data_memory[addresses]};
  assign rd_data = gm_or_lds ? rd_lds : rd_dm;
endmodule

