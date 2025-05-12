
module pipeline(clk,pixel_x,pixel_y,center_x,center_y,next_pc,d_ir,
                next_m_addr,next_m_we,mem_data,done,color);

  input  clk;
  input  [7:0] pixel_x,pixel_y;
  input  [7:0] center_x,center_y;
  output [5:0] next_pc,next_m_addr;
  output next_m_we;
  input  [15:0] d_ir,mem_data;
  output done;
  output [7:0] color;
  reg  [7:0] regs[7:0];
  reg  [5:0] pc,next_pc;
  wire [15:0] d_ir;
  reg  [5:0] d_pc,next_d_pc;
  reg  [7:0] e_sr1,next_e_sr1;
  reg  [2:0] e_drid,next_e_drid;
  reg  [15:0] e_ir,next_e_ir;
  reg  [5:0] e_pc,next_e_pc;
  reg  [5:0] m_addr,next_m_addr;
  reg  m_done,next_m_done;
  reg  next_m_we;
  reg  [7:0] m_res,next_m_res;
  reg  [2:0] m_drid,next_m_drid;
  reg  [15:0] m_ir,next_m_ir;
  wire [15:0] mem_data;
  reg  [7:0] wb_data,next_wb_data;
  reg  [7:0] wb_res,next_wb_res;
  reg  [2:0] wb_drid,next_wb_drid;
  reg  wb_done,next_wb_done;
  reg  [5:0] wb_addr,next_wb_addr;
  reg  [15:0] wb_ir,next_wb_ir;
  reg  wb_mmap,next_wb_mmap;
  reg  done;
  reg  [1:0] pc_mux;
  reg  reg_we;
  reg  [7:0] color;
  reg  [7:0] next_reg_data;
  reg  init;

  
  initial  
  begin
    init <= 1'b1;
  end
  
  always @(*)
      begin
        next_d_pc = pc+6'h01;
        case (pc_mux)

          2'b00: next_pc = pc+6'h01;

          2'b01: next_pc = 6'h00;

          default: next_pc = pc+6'h01;

        endcase

        next_e_sr1 = regs[d_ir[10:8]];
        next_e_drid = d_ir[6:4];
        next_e_ir = d_ir;
        next_e_pc = d_pc;
        if (d_ir[15:12] == 4'b0100) 
          begin
            next_e_drid = d_ir[10:8];
          end
          
        next_m_done = 1'b0;
        next_m_we = 1'b0;
        next_m_addr = e_pc+e_ir[5:0];
        next_m_res = e_sr1;
        next_m_drid = e_drid;
        next_m_ir = e_ir;
        if (e_ir[15:12] == 4'b0101) 
          begin
            next_m_we = 1'b1;
            if (next_m_addr[5] == 1'b1) 
              begin
                next_m_done = 1'b1;
                next_m_we = 1'b0;
              end
              
          end
          
        next_wb_data = 8'h03;
        next_wb_mmap = 1'b0;
        next_wb_res = m_res;
        next_wb_drid = m_drid;
        next_wb_done = m_done;
        next_wb_ir = m_ir;
        if ((m_addr[5] == 1'b1) && (m_ir[15:12] == 4'b0100)) 
          begin
            case (m_addr[4:0])

              6'h00: next_wb_data = pixel_x;

              6'h01: next_wb_data = pixel_y;

              6'h02: next_wb_data = center_x;

              6'h03: next_wb_data = center_y;

              default: next_wb_data = 8'h00;

            endcase

            next_wb_mmap = 1'b1;
          end
          
        pc_mux = 2'b00;
        done = wb_done;
        color = 8'h03;
        next_reg_data = wb_res;
        reg_we = 1'b0;
        if (wb_done == 1'b1) 
          begin
            pc_mux = 2'b01;
            done = 1'b1;
            color = wb_res;
          end
          
        if (wb_ir[15:12] == 4'b0100) 
          begin
            next_reg_data = (wb_mmap == 1'b1) ? wb_data : mem_data[7:0];
            reg_we = 1'b1;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (init == 1'b0) 
          begin
            pc <= next_pc;
          end
          
        init <= 1'b0;
        d_pc <= next_d_pc;
        e_sr1 <= next_e_sr1;
        e_drid <= next_e_drid;
        e_ir <= next_e_ir;
        e_pc <= next_e_pc;
        m_addr <= next_m_addr;
        m_done <= next_m_done;
        m_res <= next_m_res;
        m_drid <= next_m_drid;
        m_ir <= next_m_ir;
        wb_data <= next_wb_data;
        wb_res <= next_wb_res;
        wb_drid <= next_wb_drid;
        wb_done <= next_wb_done;
        wb_ir <= next_wb_ir;
        wb_mmap <= next_wb_mmap;
        if (reg_we) 
          begin
            regs[wb_drid] <= next_reg_data;
          end
          
      end
endmodule

