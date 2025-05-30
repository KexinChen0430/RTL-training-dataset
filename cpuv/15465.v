module main;
   reg clk, rst, done;
   wire [31:0] x;
   reg [3:0]  a;
   reg [23:0] in, out;
   reg [2:0]  a_fifo_cam_indices[3:0], lt_fifo_cam_indices[3:0];
   wire [2:0] db0_a_fifo_cam_indices = a_fifo_cam_indices[0];
   always
     #10 clk = ~clk;
   assign x[31:0] = { 28'hfffffff, (~a[3:0] + 4'd1) };
   initial
     begin
        $display ("\n<< BEGIN >>");
        rst             = 1'b0;
        a[3:0]          = 4'b0101;
        out[23:0]       = ( rst ?  24'o7654_3210 : in[23:0] );
        casex ( done )
           1'b1: { a_fifo_cam_indices[3],
                   a_fifo_cam_indices[2],
                   a_fifo_cam_indices[1],
                   a_fifo_cam_indices[0] } = {3'b000,
                                              lt_fifo_cam_indices[3],
                                              lt_fifo_cam_indices[2],
                                             lt_fifo_cam_indices[1]};
           1'b0: { a_fifo_cam_indices[3],
                   a_fifo_cam_indices[2],
                   a_fifo_cam_indices[1],
                   a_fifo_cam_indices[0] } = { lt_fifo_cam_indices[3],
                                               lt_fifo_cam_indices[2],
                                               lt_fifo_cam_indices[1],
                                              lt_fifo_cam_indices[0]};
        endcase
        $display ("\n<< END  >>");
        $finish(0);
     end
endmodule