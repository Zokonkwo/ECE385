
/*
NOTES:
  B --> multiplier
    This determines we either add a shifted version of the multiplicand to the accumulator or just shift without adding
  A --> Accumulator
    Holds intermiediate results of the multiplication as we add/subtract. 
    Should start at zero and accumulates shiftted multiplicand   
  S --> Multiplicand
    Number we are multiplying by the multiplier. Remains unchanged throughout the process. Shifted left by one
  After we are done multiplying the result should be stored in the Accumulator and Multiplier together. 
  X --> Carry bit

  Make a register module that has X, A, B input and output
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module controllerFSM (input Reset_Load_Clear, run, Clk, M,
                      output Shift, Add, Sub, Clr_Ld);

    //declare signals curr_state, next_state of type enum
    enum logic [3:0] {START,LOADB,CXA,AS0,AS1,AS2,AS3,AS4,AS5,AS6,SS,HALT} curr_state, next_state;

    always_ff @ (posedge CLk)
    begin
      if (Reset_Load_Clear)       //Asychronous Reset
        curr_state <= START;       //A is the reset/start state
      else
        curr_state <= next_state;
    end

    //next state logic
    always_comb
    begin
       unique case(curr_state)
          START: if(Reset_Load_Clear)
                  next_state = LOADB;

          LOADB: begin
                  SW[7:0] = Bval[7:0];
                  next_state = CXA;
                end

          CXA:  begin
                  Xval = 0;
                  Aval[7:0] = 0;
                  if(run)
                    next_state = AS0;
                end 

          always_comb
          begin    
            AS0: if(M == 1) 
                  //add S and A and then shift
                  assign Add = 1;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS1;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS1;
          end

          always_comb
          begin
            AS1: if(M == 1) 
                  //add S and A and then shift
                  assign Add = 1;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS2;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS2;
          end

          always_comb
          begin
            AS2: if(M == 1) 
                  //add S and A and then shift
                  assign Add = 1;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS3;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS3;
          end

          always_comb
          begin
            AS3: if(M == 1) 
                    //add S and A and then shift
                  assign Add = 1;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS4;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS4;
          end

          always_comb
          begin
            AS4: if(M == 1) 
                    //add S and A and then shift
                  assign Add = 1;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS5;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS5;
          end

          always_comb
          begin
            AS5: if(M == 1) 
                    //add S and A and then shift
                    assign Add = 1;
                    assign Shift = 1;
                    assign Sub = 0;
                    assign Clr_Ld = 0;
                    next_state = AS6;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = AS6;
          end 

          always_comb
          begin
            AS6: if(M == 1) 
                    //add S and A and then shift
                    assign Add = 1;
                    assign Shift = 1;
                    assign Sub = 0;
                    assign Clr_Ld = 0;
                    next_state = SS;  
                else if (M == 0) 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = SS;
          end

          always_comb
          begin
            SS: if(M == 1)
                  //A become A - S and shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 1;
                  assign Clr_Ld = 0;
                  next_state = HALT;
                else 
                  //just shift
                  assign Add = 0;
                  assign Shift = 1;
                  assign Sub = 0;
                  assign Clr_Ld = 0;
                  next_state = HALT;
          end

          HALT: if(run)
              next_state = CXA;

          default: next_state = START;
    end
        endcase

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module add_sub5(input     [7:0] A, B,
                input       fn,
                output    [4:0] S);

    //useful shortcut - bit extension {4{fn}};

    logic [4:0] BB;
    assign BB = B^fn;

    if (fn == 1)
      //then inverting switches
      //after inverting call CRA 9 times
      //lastly add 1;
      //send result to A
      //send Cout from CRA to X
  

    else if (fn == 0)
      //then add switches normally as postive number
       //instantiate the CRA 9 times;
       //send result to A
       //send Cout from CRA to X

    
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module reg_8(input logic      Clk, Reset, Shift_In, Load, Shift_En,
            input logic      [7:0] D,
            output logic     Shift_Out,
            output logic     [7:0] Data_Out);


    always_ff @ (posedge Clk)
    begin
      if(Reset)
        Data_Out <= 8'h0;
      else if (Load)
        Data_Out <= D;
      else if (Shift_En)
        Data_Out <= {Shift_In, Data_Out[7:1]};
    end
    
    assign Shift_Out = Data_Out[0];


 endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module reg_S(input logic [7:0] S,
             output logic [7:0] S_out);

      //sliding switches


