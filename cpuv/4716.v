module rxr16 (
    input      [15:0] x,   
    input             ci,  
    input      [ 4:0] y,   
    input             e,   
    output reg [15:0] w,   
    output reg        co   
);
always @(x or ci or y or e)
    case (y)
      default: {co,w} <= {ci,x};
      5'd01: {co,w} <= e ? {x[0], ci, x[15:1]} : {ci, x[0], x[15:1]};
      5'd02: {co,w} <= e ? {x[1:0], ci, x[15:2]} : {ci, x[1:0], x[15:2]};
      5'd03: {co,w} <= e ? {x[2:0], ci, x[15:3]} : {ci, x[2:0], x[15:3]};
      5'd15: {co,w} <= e ? {x[14:0], ci, x[15]} : {ci, x[14:0], x[15]};
      5'd16: {co,w} <= {x,ci};
    endcase
endmodule