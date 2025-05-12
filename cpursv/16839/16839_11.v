
module excute(clock,in_op,in_src1,in_src2,in_dst,in_imm,out_dst,
              out_dst_data,write_dst,dmem_address,dmem_data,dmem_write,
              dmem_read,cnt_ex,cnt_read,in_databus,in_databus2);

  input  clock;
  input  [31:0] in_op;
  input  signed  [31:0] in_src1,in_src2;
  input  [4:0] in_dst;
  input  [31:0] in_imm;
  inout  [31:0] dmem_data;
  input  [63:0] in_databus,in_databus2;
  output [31:0] dmem_address;
  output [4:0] out_dst;
  output [31:0] out_dst_data;
  output write_dst;
  output dmem_write;
  output dmem_read;
  output cnt_read;
  output cnt_ex;
  reg  [31:0] opcode;
  reg  signed  [31:0] source1,source2;
  reg  [4:0] destination;
  reg  signed  [31:0] immediate;
  reg  signed  [31:0] result;
  reg  r_write_dst;
  reg  r_dmem_write,r_dmem_read;
  reg  r_cnt_read;
  reg  r_cnt_ex;

  assign out_dst = destination;
  assign out_dst_data = result;
  assign write_dst = r_write_dst;
  assign dmem_write = r_dmem_write;
  assign dmem_read = r_dmem_read;
  assign dmem_address = immediate;
  assign dmem_data = r_dmem_read ? 32'hz : source2;
  assign cnt_read = r_cnt_read;
  assign cnt_ex = r_cnt_ex;
  
  always @(posedge clock)
      begin
        r_cnt_read <= 0;
        r_cnt_ex <= 0;
        if ((in_databus[63:48] !== 16'b100000_00000_00000) && 
            (in_databus2[63:48] !== 16'b100000_00000_00000)) 
          begin
            if (!((immediate === 0) && 
((source2 === 0) && (opcode === 1)))) 
              begin
                r_cnt_ex <= 1;
              end
              
            casex (opcode)

              1: begin
                    result <= source2<<<immediate;
                    #0.01 r_write_dst <= 1;
                  end

              2: begin
                    result <= (immediate[15:15] === 1) ? (source1-(~{16'b1111111111111111,immediate[15:0]}+1)) : (source1+immediate);
                    #0.01 r_write_dst <= 1;
                  end

            endcase

          end
          
      end
  
  always @(negedge clock)
      begin
        #0.01 
          if (in_databus[63:48] !== 16'b100000_00000_00000) 
            begin
              opcode <= in_op;
              source1 <= in_src1;
              source2 <= in_src2;
              immediate <= in_imm;
              destination <= in_dst;
              r_write_dst <= 0;
              r_dmem_write <= 0;
              r_dmem_read <= 0;
            end
            

      end
endmodule

