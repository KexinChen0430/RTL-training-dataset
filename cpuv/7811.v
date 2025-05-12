module cam
  (
   input                clk, 
   input                rst, 
   input                camen, 
   input                inval, 
   input [30:0]         cdat, 
   output logic [255:0] hitvec_d1r, 
   output logic [7:0]   hitidx_d1r, 
   output logic         hit_d2r, 
   input                ren, 
   input                wen, 
   input [30:0]         wdat, 
   input                wdat_val, 
   input [7:0]          rwidx, 
   output logic [30:0]  rdat_d2r, 
   output logic         rdat_val_d2r 
   );
   logic                camen_d1r;
   logic                inval_d1r;
   logic                ren_d1r;
   logic                wen_d1r;
   logic [7:0]          rwidx_d1r;
   logic [30:0]         cdat_d1r;
   logic [30:0]         wdat_d1r;
   logic                wdat_val_d1r;
   always_ff @(posedge clk) begin
      camen_d1r <= camen;
      inval_d1r <= inval;
      ren_d1r <= ren;
      wen_d1r <= wen;
      cdat_d1r <= cdat;
      rwidx_d1r <= rwidx;
      wdat_d1r <= wdat;
      wdat_val_d1r <= wdat_val;
   end
   typedef struct packed {
      logic [30:0] data; 
      logic        valid; 
   } entry_t;
   entry_t [255:0] entries;
   always_ff @(posedge clk) begin
      if (camen_d1r) begin
         for (int i = 0; i < 256; i = i + 1) begin
            hitvec_d1r[i] <= entries[i].valid & (entries[i].data == cdat_d1r);
         end
      end
   end
   always_ff @(posedge clk) begin
      hit_d2r <= | hitvec_d1r;
   end
   always_ff @(posedge clk) begin
      if (rst) begin 
         for (int i = 0; i < 256; i = i + 1) begin
            entries[i] <= '0;
         end
      end
      else if (wen_d1r) begin 
         entries[rwidx_d1r] <= '{valid:wdat_val_d1r, data:wdat_d1r};
      end
      else if (inval_d1r) begin 
         for (int i = 0; i < 256; i = i + 1) begin
            entries[i] <= '{valid:'0, data:entries[i].data};
         end
      end
   end
   always_ff @(posedge clk) begin
      if (ren_d1r) begin
         rdat_d2r <= entries[rwidx_d1r].data;
         rdat_val_d2r <= entries[rwidx_d1r].valid;
      end
   end
endmodule