
module acl_registered_comparison(clock,left,right,enable,result);

  parameter  WIDTH = 32;
  input  clock,enable;
  input  [WIDTH-1:0] left;
  input  [WIDTH-1:0] right;
  output result;
  localparam  SECTION_SIZE = 4;
  localparam 
       SECTIONS = (((((0%SECTION_SIZE)+WIDTH)+(0%SECTION_SIZE))%SECTION_SIZE) == 0) ? (WIDTH/SECTION_SIZE) : ((WIDTH/SECTION_SIZE)+1);
  reg  [SECTIONS+(0-1):0] comparisons;
  wire [SECTIONS*SECTION_SIZE:0] 
       temp_left = {{{((SECTIONS*SECTION_SIZE)-WIDTH)+1}{1'b0}},left};
  wire [SECTIONS*SECTION_SIZE:0] 
       temp_right = {{{((SECTIONS*SECTION_SIZE)-WIDTH)+1}{1'b0}},right};

  genvar i;
  
  generate
      for (i = 0; i < SECTIONS; i = 1+i)
          begin : cmp
            
            always @(posedge clock)
                begin
                  if (enable) 
                    comparisons[i] <= temp_left[(0-1)+((1+i)*SECTION_SIZE):SECTION_SIZE*i] == temp_right[(0-1)+((1+i)*SECTION_SIZE):SECTION_SIZE*i];
                    
                end
          end
  endgenerate

  assign result = &comparisons;
endmodule

