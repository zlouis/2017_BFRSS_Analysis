using DataFrames
using CSV
using VegaLite


#set output file name for data extraction
output_file_name = "output.csv" 
output_file = open(output_file_name,"w")  

#check for values, remove blank/empty space responses, including: "don't know" & "Refused" responses
function getValue(vals,stype)
    result = "NA"
    if stype == 1 
        if vals != ' ' && vals != " " && vals != "  " && vals != '7' && vals !='9' && vals !="" 
            result = string(vals)
            return result
        end
    elseif vals != ' ' && vals != " " && vals != "  " && vals != "77" && vals != "99" && vals !=""
            result = string(vals)
         end
    return result
end



##start to extract data
input_data = open("/Users/louishuang/Desktop/project1/LLCP2017.asc") 
for line in readlines(input_data)
 line  = chomp(line)

  # 44 = Rhode Island or 23 = Maine
  if line[1:2]=="44" 


 state                            = getValue(line[1:2],1)       # state
 marital_status                   = getValue(line[162],1)       # marital_status - married, divorced, widowed etc..
 interview_month                  = getValue(line[19:20],1)     # IMONTH   - Interview Month
 gender                           = getValue(line[78],1)        # CADULT   - Are you 18 years of age or older?1, male, 2 female     
 employment_status                = getValue(line[177],1)       # EMPLOY1  - employment_status
 income_lvl                       = getValue(line[180:181],2)   # INCOME2  - Income Level
 told_arthritis                   = getValue(line[114],1)       # HAVARTH3 - Told Have Arthritis
 arthiritis_limit                 = getValue(line[120],1)       # LMTJOIN3 - Limited Because of Joint Symptoms
 arthiritis_affect_work           = getValue(line[121],1)       # ARTHDIS2 - Does Arthritis Affect Whether You Work
 arthiritis_activity              = getValue(line[122],1)       # ARTHSOCL - Social Activities Limited Because of Joint Symptoms
 joint_pain_lvl                   = getValue(line[123:124],2)   # JOINPAI1 - How Bad Was Joint Pain
 past_30day_exercise              = getValue(line[233],1)       # EXERANY2 - Exercise in Past 30 Days  



 write(output_file, "$state,$marital_status,$interview_month,$gender,$employment_status,$income_lvl,$told_arthritis,$arthiritis_limit, $arthiritis_affect_work,$arthiritis_activity,$joint_pain_lvl,$past_30day_exercise\n")



end

end

	close(output_file)

    #Write column headers to dataframe and push to outputfile, csv
    df = CSV.read("/Users/louishuang/Desktop/project1/output.csv")

        names!(df, [:state,:marital_status,:interview_month,:gender,:employment_status,:income_lvl,:told_arthritis,:arthiritis_limit,:arthiritis_affect_work,:arthiritis_activity,:joint_pain_lvl,:past_30day_exercise])
    
         df=df[df.marital_status .!="NA",:]

         #convert interview month column of int to string
         df[:interview_month] = string.(collect(df[:interview_month]))

         CSV.write("/Users/louishuang/Desktop/project1/output.csv", df)

#controller
# df=df[df.marital_status .=["1","2","3","4","5","6"]]
# df[:marital_status] = [if df[:marital_status] ==."3" "Rhode Island" for x in df[:marital_status]]


#state categories#
# df[df[:state] .==44,:state] = "Rhode Island"
# df[:state] = ["Rhode Island" for x in df[:state]]

######################################################################
###### Reformate dataframe values to readable string catagory values #
###### then write to csv                                             #
######################################################################
#Married
df[df[:marital_status] .=="1",:marital_status] = "Married"
df[df[:marital_status] .=="2",:marital_status] = "Divorced"
df[df[:marital_status] .=="3",:marital_status] = "Widowed"
df[df[:marital_status] .=="4",:marital_status] = "Separated"
df[df[:marital_status] .=="5",:marital_status] = "Never married"
df[df[:marital_status] .=="6",:marital_status] = "A member of an unmarried couple"

#interview_month
df[df[:interview_month] .== "1",:interview_month] = "January"
df[df[:interview_month] .== "2",:interview_month] = "Feburary"
df[df[:interview_month] .== "3",:interview_month] = "March"
df[df[:interview_month] .== "4",:interview_month] = "April"
df[df[:interview_month] .== "5",:interview_month] = "May"
df[df[:interview_month] .== "6",:interview_month] = "June"
df[df[:interview_month] .== "7",:interview_month] = "July"
df[df[:interview_month] .== "8",:interview_month] = "August"
df[df[:interview_month] .== "9",:interview_month] = "September"
df[df[:interview_month] .== "10",:interview_month] = "October"
df[df[:interview_month] .== "11",:interview_month] = "November"
df[df[:interview_month] .== "12",:interview_month] = "December"

#gender
df[df[:gender] .=="1",:gender] = "Male"
df[df[:gender] .=="2",:gender] = "Female"

#Employment status
df[df[:employment_status] .=="1",:employment_status] = "Employed for wages"
df[df[:employment_status] .=="2",:employment_status] = "Self-employed"
df[df[:employment_status] .=="3",:employment_status] = "Out of work for 1 year or more"
df[df[:employment_status] .=="4",:employment_status] = "Out of work for less than 1 year"
df[df[:employment_status] .=="5",:employment_status] = "A homemaker"
df[df[:employment_status] .=="6",:employment_status] = "A student"
df[df[:employment_status] .=="7",:employment_status] = "Retired"
df[df[:employment_status] .=="8",:employment_status] = "Unable to work"

#income_lvl
df[df[:income_lvl] .=="01",:income_lvl] = "Less than \$10,000"
df[df[:income_lvl] .=="02",:income_lvl] = "\$10,000 to \$15,000"
df[df[:income_lvl] .=="03",:income_lvl] = "\$15,000 to less than \$20,000"
df[df[:income_lvl] .=="04",:income_lvl] = "\$20,000 to less than \$25,000"
df[df[:income_lvl] .=="05",:income_lvl] = "\$25,000 to less than \$35,000"
df[df[:income_lvl] .=="06",:income_lvl] = "\$35,000 to less than \$50,000"
df[df[:income_lvl] .=="07",:income_lvl] = "\$50,000 to less than \$75,000"
df[df[:income_lvl] .=="08",:income_lvl] = "\$75,000 or more"

# told_arthritis 
df[df[:told_arthritis] .=="1",:told_arthritis] = "Yes"
df[df[:told_arthritis] .=="2",:told_arthritis] = "No"

#LMTJOIN3
df[df[:arthiritis_limit] .=="1",:arthiritis_limit] = "Yes"
df[df[:arthiritis_limit] .=="2",:arthiritis_limit] = "No"

#ARTHDIS2

# df[:arthiritis_affect_work] = ["Rhode Island" for x in df[:arthiritis_affect_work]]
df[df[:arthiritis_affect_work] .==" 1",:arthiritis_affect_work] = "Yes"
df[df[:arthiritis_affect_work] .==" 2",:arthiritis_affect_work] = "No"


#ARTHSOCL
df[df[:arthiritis_activity] .=="1",:arthiritis_activity] = "A lot"
df[df[:arthiritis_activity] .=="2",:arthiritis_activity] = "A little"
df[df[:arthiritis_activity] .=="3",:arthiritis_activity] = "Not at all "

##write above catagorical values to csv
CSV.write("/Users/louishuang/Desktop/project1/output.csv", df)



#######################################################################################
############################### VegaLite Graphs########################################
#######################################################################################

###initial test plots###
df |> @vlplot(:point, encoding={ x=:joint_pain_lvl, y=:arthiritis_affect_work}, color=:arthiritis_limit)
# df |> @vlplot(:bar, x=:joint_pain_lvl, y="count()", transform=[{filter= {field= "joint_pain_lvl", range= [0, 100]}}])
#############################################
### Graph 1, Employment_status vs pain scale#
#############################################

# df |> @vlplot(:circle, title="Employment Status vs Joint Pain Level", x={field=:employment_status, axis= {title="Employment Status", labelAngle=300}}, 
#                        y={field=:joint_pain_lvl, axis= {title="Joint Pain Level"}, sort="descending"}, 
#                       size={aggregate="count", type="quantitative"}, 
#                         transform= [{ 
#                                 filter= {and= [
#                                          {field= "joint_pain_lvl", range= [1, 10]},
#                                          {field= "employment_status", oneOf= ["Employed for wages", 
#                                                  "Self-employed", "Out of work for 1 year or more", "Out of work for less than 1 year", 
#                                                  "A homemaker", "A student", "Unable to work"]}
#     ]}
#   }])

###################################################################
### Graph 2, Employment wages vs income_lvl relative to pain scale#
###################################################################

# df |> @vlplot(:bar, title="Income level vs Pain Scale",x={field= :income_lvl, axis= {title="Income level", labelAngle=300}, sort=["Less than \$10,000", "\$10,000 to \$15,000)", 
#                                 "\$15,000 to less than \$20,000", "\$15,000 to less than \$20,000",
#                                 "\$20,000 to less than \$25,000", "\$25,000 to less than \$35,000", 
#                                 "\$35,000 to less than \$50,000", "\$50,000 to less than \$75,000",
#                                 "\$75,000 or more"]},  
#                    y={field=:joint_pain_lvl, axis= {title="Joint Pain Level"}, sort="descending"}, color={field=:employment_status, aggregate="count", type="quantitative"}, 

#     transform=[{filter= {and= [
#                                {field= "joint_pain_lvl", range= [1, 10]},
#                                {field= "employment_status", oneOf= ["Employed for wages"]},
#                                {field="income_lvl", oneOf=["Less than \$10,000", "\$10,000 to \$15,000)", 
#                                 "\$15,000 to less than \$20,000", "\$15,000 to less than \$20,000",
#                                 "\$20,000 to less than \$25,000", "\$25,000 to less than \$35,000", "\$35,000 to less than \$50,000", 
#                                 "\$50,000 to less than \$75,000","\$75,000 or more"]}
#     ]}}])

#######################################################
###Graph 3 Yes/No responses, if arthiritis affect work#
#######################################################

# df |> @vlplot(:bar, title="Arthiritis vs Work", x ={field = :employment_status, axis= {title="Employment Status", labelAngle=300}}, y = {aggregate="count", type = "quantitative"}, color = {field = :arthiritis_affect_work, 
#                     type = "nominal", scale = {domain = ["Yes", "No"], range = ["F58518", "4C78A8"]}, legend={title="Arthiritis Affect Work?"}}, 
#     transform= [{ filter= {and= [
#                   {field= "arthiritis_affect_work", oneOf = ["Yes", "No"]},
#                   {field= "employment_status", oneOf = ["Employed for wages", 
#                           "Self-employed", "Out of work for 1 year or more", 
#                           "Out of work for less than 1 year", 
#                           "A homemaker married", "A student", "Retired", "Unable to work"]}
#     ]}
#   }])

##############################################
### Graph 4, Gender vs arthiritis affect work#
##############################################

# df |> @vlplot(:bar, title="Gender Vs Arthiritis at Work", labelAngle=45, x={field=:arthiritis_affect_work, axis={ title="Arthiritis Affect Work", labelAngle=300}}, y=:"count()",
#     color={field=:gender, type="nominal"}, 
     
#     transform= [{
#     filter= {and= [
#       {field= "arthiritis_affect_work", oneOf= ["Yes", "No"]},
#        {field= "gender", oneOf= ["Male", "Female"]}
#     ]}
#   }])

############################################
####### Arthiritis throughout the season####
############################################

df |> @vlplot(:bar, title="Arthiritis vs Month", x ={field = :interview_month, sort=["January", 
                          "Feburary", "March", 
                          "April", 
                          "May", "June", "July", "August", "September", "October", "November", "December"],
    axis= {title="Interview Month", labelAngle=300}}, y = {aggregate="count", type = "quantitative", scale={domain=[0,300]}}, color = {field = :told_arthritis, 
                    type = "nominal", scale = {domain = ["Yes"], range = ["F58518"]}, legend={title="Told by Doctor to have Arthiritis"}}, 
    transform= [{ filter= {and= [
                  {field= "told_arthritis", oneOf = ["Yes"]},
                  {field= "interview_month", oneOf = ["January", 
                          "Feburary", "March", 
                          "April", 
                          "May", "June", "July", "August", "September", "October", "November", "December"]}
    ]}
  }])





##standard deviation
# df |> @vlplot(:circle, x={field= :income_lvl, sort=["Less than \$10,000", "\$10,000 to \$15,000)", 
#                                 "\$15,000 to less than \$20,000", "\$15,000 to less than \$20,000",
#                                 "\$20,000 to less than \$25,000", "\$25,000 to less than \$35,000", "\$35,000 to less than \$50,000", 
#                                 "\$50,000 to less than \$75,000","\$75,000 or more"]},  y={field=:joint_pain_lvl, sort="descending"}, color={field=:employment_status, aggregate="count", type="nominal"}, 
#     transform=[{filter= {and= [
#                                {field= "joint_pain_lvl", range= [1, 10]},
#                                {field= "employment_status", oneOf= ["Employed for wages"]},
#                                {field="income_lvl", oneOf=["Less than \$10,000", "\$10,000 to \$15,000)", 
#                                 "\$15,000 to less than \$20,000", "\$15,000 to less than \$20,000",
#                                 "\$20,000 to less than \$25,000", "\$25,000 to less than \$35,000", "\$35,000 to less than \$50,000", 
#                                 "\$50,000 to less than \$75,000","\$75,000 or more"]},


#     ]}}],
#     layer=[{

#               mark= {type= "errorband", extent= "stdev", opacity= 0.2},
#       encoding= {
#         y= {
#           field= :joint_pain_lvl,
#           type= "quantitative",
#           title= "pain level vs income level"
#         }
#       },
#       mark="rule",
#       encoding= {
#         y= {
#           field=:joint_pain_lvl,
#           type= "quantitative",
#           aggregate= "mean"
#         }
#       }
#     }]

#     )
                     

