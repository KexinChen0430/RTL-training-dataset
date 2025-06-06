
module SHDCollector  #(parameter  DNA_DATA_WIDTH = 128, NUM_PES = 4)
  (input  clk,
   input  rst,
   output reg [NUM_PES-1:0] pe_rd_en,
   input  [(0-1)+(NUM_PES*8):0] pe_data,
   input  [NUM_PES-1:0] pe_valid,
   input  sender_ready,
   output sender_data_valid,
   output [7:0] sender_data);

  wire pe_fetched;
  parameter  PE_BITS = $clog2(NUM_PES);
  reg  [PE_BITS+(0-1):0]  pe_iterator = 0;
  wire advance_pe_it;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            pe_iterator <= 0;
          end
        else 
          begin
            if (advance_pe_it) 
              begin
                pe_iterator <= 1'b1+pe_iterator;
              end
              
          end
      end
  assign advance_pe_it = pe_fetched;
  reg  [7:0] dna_err_r;

  reg  dna_err_valid_r;

  wire accept_pe_data;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            dna_err_r <= 0;
            dna_err_valid_r <= 1'b0;
          end
        else 
          begin
            if (accept_pe_data) 
              begin
                dna_err_r <= pe_data[pe_iterator*8 +: 8];
                dna_err_valid_r <= pe_valid[pe_iterator];
              end
              
          end
      end
  
  always @* 
      begin
        pe_rd_en = 0;
        pe_rd_en[pe_iterator] = accept_pe_data;
      end
  assign pe_fetched = pe_valid[pe_iterator] && accept_pe_data;
  assign accept_pe_data = sender_ready;
  assign sender_data_valid = dna_err_valid_r;
  assign sender_data = dna_err_r;
endmodule

