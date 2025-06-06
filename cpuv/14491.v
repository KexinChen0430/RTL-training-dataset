module processing_system7_bfm_v2_0_arb_rd(
 rstn,
 sw_clk,
 qos1,
 qos2,
 prt_req1,
 prt_req2,
 prt_bytes1,
 prt_bytes2,
 prt_addr1,
 prt_addr2,
 prt_data1,
 prt_data2,
 prt_dv1,
 prt_dv2,
 prt_req,
 prt_qos,
 prt_addr,
 prt_bytes,
 prt_data,
 prt_dv
);
`include "processing_system7_bfm_v2_0_local_params.v"
input rstn, sw_clk;
input [axi_qos_width-1:0] qos1,qos2;
input prt_req1, prt_req2;
input [addr_width-1:0] prt_addr1, prt_addr2;
input [max_burst_bytes_width:0] prt_bytes1, prt_bytes2;
output reg prt_dv1, prt_dv2;
output reg [max_burst_bits-1:0] prt_data1,prt_data2;
output reg prt_req;
output reg [axi_qos_width-1:0] prt_qos;
output reg [addr_width-1:0] prt_addr;
output reg [max_burst_bytes_width:0] prt_bytes;
input [max_burst_bits-1:0] prt_data;
input prt_dv;
parameter wait_req = 2'b00, serv_req1 = 2'b01, serv_req2 = 2'b10,wait_dv_low = 2'b11;
reg [1:0] state;
always@(posedge sw_clk or negedge rstn)
begin
if(!rstn) begin
 state = wait_req;
 prt_req = 1'b0;
 prt_dv1 = 1'b0;
 prt_dv2 = 1'b0;
 prt_qos = 0;
end else begin
 case(state)
 wait_req:begin
         state = wait_req;
         prt_dv1 = 1'b0;
         prt_dv2 = 1'b0;
         prt_req = 0;
         if(prt_req1 && !prt_req2) begin
           state = serv_req1;
           prt_req = 1;
           prt_qos = qos1;
           prt_addr = prt_addr1;
           prt_bytes = prt_bytes1;
         end else if(!prt_req1 && prt_req2) begin
           state = serv_req2;
           prt_req = 1;
           prt_qos = qos2;
           prt_addr = prt_addr2;
           prt_bytes = prt_bytes2;
         end else if(prt_req1 && prt_req2) begin
           if(qos1 > qos2) begin
             prt_req = 1;
             prt_qos = qos1;
             prt_addr = prt_addr1;
             prt_bytes = prt_bytes1;
             state = serv_req1;
           end else if(qos1 < qos2) begin
             prt_req = 1;
             prt_addr = prt_addr2;
             prt_qos = qos2;
             prt_bytes = prt_bytes2;
             state = serv_req2;
           end else begin
             prt_req = 1;
             prt_qos = qos1;
             prt_addr = prt_addr1;
             prt_bytes = prt_bytes1;
             state = serv_req1;
           end
         end
       end
 serv_req1:begin
         state = serv_req1;
         prt_dv2 = 1'b0;
         if(prt_dv) begin
           prt_dv1 = 1'b1;
           prt_data1 = prt_data;
           prt_req = 0;
           if(prt_req2) begin
             prt_req = 1;
             prt_qos = qos2;
             prt_addr = prt_addr2;
             prt_bytes = prt_bytes2;
             state = serv_req2;
           end else begin
             state = wait_dv_low;
           end
         end
       end
 serv_req2:begin
         state = serv_req2;
         prt_dv1 = 1'b0;
         if(prt_dv) begin
           prt_dv2 = 1'b1;
           prt_data2 = prt_data;
           prt_req = 0;
           if(prt_req1) begin
             prt_req = 1;
             prt_qos = qos1;
             prt_addr = prt_addr1;
             prt_bytes = prt_bytes1;
             state = serv_req1;
           end else begin
             state = wait_dv_low;
           end
         end
       end
 wait_dv_low:begin
         prt_dv1 = 1'b0;
         prt_dv2 = 1'b0;
         state = wait_dv_low;
         if(!prt_dv)
           state = wait_req;
       end
 endcase
end 
end 
endmodule