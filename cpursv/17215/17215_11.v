
module e16_arbiter_roundrobin(grants,clk,clk_en,reset,en_rotate,requests);

  parameter  ARW = 5;
  input  clk;
  input  clk_en;
  input  reset;
  input  en_rotate;
  input  [(-1)+ARW:0] requests;
  output [(-1)+ARW:0] grants;
  integer m;
  reg  [(-1)+ARW:0] request_mask;
  reg  [ARW<<1-1:0] grants_rotate_buffer;
  reg  [(-1)+ARW:0] grants;
  wire [(-1)+ARW:0] shifted_requests[(-1)+ARW:0];
  wire [(-1)+ARW:0] shifted_grants[(-1)+ARW:0];
  wire [ARW<<1-1:0] requests_rotate_buffer;

  
  always @(posedge clk or posedge reset)
      if (reset) request_mask[(-1)+ARW:0] <= {{(-1)+ARW{1'b0}},1'b1};
      else if (clk_en) 
        if (en_rotate) 
          request_mask[(-1)+ARW:0] <= {request_mask[(-2)+ARW:0],request_mask[(-1)+ARW]};
          
        
  assign requests_rotate_buffer[ARW<<1-1:0] = {requests[(-1)+ARW:0],requests[(-1)+ARW:0]};
  genvar i;
  
  generate
      for (i = 0; i < ARW; i = i+1)
          begin : gen_requests
            assign shifted_requests[i] = requests_rotate_buffer[i+((-1)+ARW):i];
          end
  endgenerate

  genvar k;
  
  generate
      for (k = 0; k < ARW; k = k+1)
          begin : gen_arbiter
            e16_arbiter_priority #(.ARW(ARW)) simple_arbiter(.clk(clk),
                                                             .clk_en(clk_en),.reset(reset),
                                                             .hold(1'b0),.request(shifted_requests[k]),
                                                             .arb_wait(),.grant(shifted_grants[k]));
          end
  endgenerate

  
  always @* 
      begin
        grants[(-1)+ARW:0] = {ARW{1'b0}};
        for (m = 0; m < ARW; m = m+1)
            begin
              grants_rotate_buffer[ARW<<1-1:0] = {shifted_grants[m],shifted_grants[m]};
              grants[(-1)+ARW:0] = (((grants_rotate_buffer[((-m)+ARW<<1)+(-1) -: ARW] | {ARW{request_mask[m]}}) & (grants_rotate_buffer[((-m)+ARW<<1)+(-1) -: ARW] | grants[(-1)+ARW:0])) & ({ARW{request_mask[m]}} | grants[(-1)+ARW:0])) | grants[(-1)+ARW:0];
            end
      end
endmodule

