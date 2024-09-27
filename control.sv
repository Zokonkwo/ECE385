

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
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module controllerFSM (input logic Reset_Load_Clr, run, Clk, M_val,
                      output logic Shift, Add, Sub, Clr, LoadB);

    //declare signals curr_state, next_state of type enum
    enum logic [9:0]{START,CXA, LOADB,IDLE,A0,SH0,OPERATION,BUFFER0,BUFFER1,BUFFER2,BUFFER3,BUFFER4,BUFFER5,BUFFER6,BUFFER7, A1,SH1,A2,SH2,A3,SH3,A4,SH4,A5,SH5,SH7,A6,SH6,SS,HALT, HALT2} curr_state, next_state;

  logic [7:0] Bval;
  logic [7:0] Aval;
    //assign outputs based on state
    always_comb
    begin 
      unique case(curr_state)
        START: 
            begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
      
        CXA:
         begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b1; 
            LoadB = 1'b0;
    
          end
        LOADB:
          begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0; 
            LoadB = 1'b1;
    
          end
        A0:
          begin
            Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
        SH0:
            begin
                Shift = 1'b1;
                Add = 1'b0;
                Sub = 1'b0;
                Clr = 1'b0;
                LoadB = 1'b0;
            end
        A1:
          begin
           Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0; 
          end
        SH1:
            begin
                Shift = 1'b1;
                Add = 1'b0;
                Sub = 1'b0;
                Clr = 1'b0;
                LoadB = 1'b0;
            end
        A2:
          begin
            Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0; 
          end
        SH2:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        A3:
          begin
            Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
       SH3:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        A4:
          begin
            Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0; 
          end
       SH4:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        A5:
          begin
           Shift = 1'b0; 
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;   
          end
       SH5:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        A6:
          begin
            Shift = 1'b0;
            Add = 1'b1;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0; 
          end
       SH6:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        SH7:
        begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
        end
        SS:
          begin
            Shift = 1'b0;
            Add = M_val;
            Sub = 1'b1;
            Clr = 1'b0; 
            LoadB = 1'b0;
          end
        HALT:
          begin
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;     
          end
          
          HALT2:
          begin
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
          end
            
            OPERATION:
              begin
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
              end
              
         
        default:  //default case, can also have default assignments 
          begin 
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
          end
          endcase
    end

    ////////////////next state logic/////////////////////////////////////////////////////////////////////////////////
    always_comb
    begin
     next_state = curr_state;
       unique case(curr_state)
          START: 
          begin
            if(run == 1)
                next_state = OPERATION;
             else
             next_state = START;
              end
         
              
         LOADB: next_state = CXA;
         
          CXA: next_state = START;
          OPERATION:
            begin
                if(M_val == 1)
                    next_state = A0;
                 else
                    next_state = SH0; 
            end
            A0: next_state = SH0; 
            SH0: next_state = BUFFER0;
            BUFFER0:
               begin
                if(M_val == 1)
                    next_state = A1;
                 else
                    next_state = SH1; 
                end
            A1: next_state = SH1;
            SH1: next_state = BUFFER1;
            BUFFER1:
               begin
                if(M_val == 1)
                    next_state = A2;
                 else
                    next_state = SH2;
                end
            A2: next_state = SH2;
            SH2: next_state = BUFFER2;
            BUFFER2:
               begin
                if(M_val == 1)
                    next_state = A3;
                 else
                    next_state = SH3;
                end
            A3: next_state = SH3;
            SH3: next_state = BUFFER3;
            BUFFER3:
               begin
                if(M_val == 1)
                    next_state = A4;
                 else
                    next_state = SH4;
                end
            A4: next_state = SH4;
            SH4: next_state = BUFFER4;
            BUFFER4:
               begin
                if(M_val == 1)
                    next_state = A5;
                 else
                    next_state = SH5;
                end
            A5: next_state = SH5;
            SH5: next_state = BUFFER5;
            BUFFER5:
               begin
                if(M_val == 1)
                    next_state = A6;
                 else
                    next_state = SH6;
                end
            A6: next_state = SH6;
            SH6: next_state = BUFFER6;
            BUFFER6:
            begin
                   if(M_val == 1)
                       next_state = SS;
                   else 
                       next_state = SH7;
                end
            SS: next_state = SH7;
            BUFFER7: next_state = HALT;

            SH7: next_state = BUFFER7;
                  
  


          HALT: 
          begin
             if (run == 1)
                 next_state = LOADB;
             end

        endcase
    end

    //update flip-flops
    always_ff @ (posedge Clk)
    begin
      if (Reset_Load_Clr)       //Asychronous Reset
        curr_state <= LOADB;       //A is the reset/start state
      else
        curr_state <= next_state;
    end
      
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
