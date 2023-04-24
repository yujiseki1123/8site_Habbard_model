using Combinatorics
using LinearAlgebra

a = [0,0,0,0,1,1,1,1]
b = [0,0,0,0,1,1,1,1]
#a = [0,1]
ele_1 = unique(collect(permutations(a)))
#ele_2 = ele_1
ele_2 = unique(collect(permutations(b)))
spins = Array[]
for x in ele_1
    for y in ele_2
        new = [[x,y]]
        append!(spins,new)
    end
end 

t = -1
U = 20

n = length(spins)
m = length(spins[1][1])

ham = zeros(n,n)

#符号関数

# tと-tの埋め込み
for i = 1:n
    for j = 1:n
        if i == j 
            continue 
        end
        if spins[i][1] == spins[j][1]
            for k = 1:m
                if k==m 
                    l = 1 
                else 
                    l = k + 1
                end 
                
                spin_tmp = copy(spins[i][2])


                if spins[i][2][k] == 0 && spins[i][2][l] == 1 
                    spin_tmp[k] = 1 
                    spin_tmp[l] = 0 

                elseif spins[i][2][k] == 1 && spins[i][2][l] == 0
                    spin_tmp[k] = 0
                    spin_tmp[l] = 1 

                else 
                    continue 
                end 
                
                #反交換関係による符号変換
                if spin_tmp == spins[j][2]
                    if l == 1 
                        if spins[j][1][l] == 1 
                            ham[i,j] = t 
                        else 
                            ham[i,j] = -t 
                        end 
                    else 
                        if spins[j][1][l] == 1 
                            ham[i,j] = -t
                        else 
                            ham[i,j] = t 
                        end 
                    end 
                    #println(spins[i]," ",spins[j])
                    break 
                end  
            end

        elseif spins[i][2] == spins[j][2]
            for k = 1:m
                if k==m 
                    l = 1 
                else 
                    l = k + 1
                end

                spin_tmp = copy(spins[i][1])

                if spins[i][1][k] == 0 && spins[i][1][l] == 1 
                    spin_tmp[k] = 1 
                    spin_tmp[l] = 0 
                elseif spins[i][1][k] == 1 && spins[i][1][l] == 0
                    spin_tmp[k] = 0
                    spin_tmp[l] = 1 
                end 
                
                #反交換関係による符号変換
                if spin_tmp == spins[j][1]
                    if l == 1 
                        if spins[j][2][k] == 1
                            ham[i,j] = t 
                        else 
                            ham[i,j] = -t 
                        end   
                    else 
                        if spins[j][2][k] == 1 
                            ham[i,j] = -t 
                        else 
                            ham[i,j] = t
                        end 
                    end 
                    #println(spins[i]," ",spins[j])
                    break 
                end  
            end
        end 
    end
end 

#Uの埋め込み

for i = 1:n 
    for j = 1:m 
        if spins[i][1][j] == 1 && spins[i][2][j] == 1
            ham[i,i] = ham[i,i] + U
        end 
    end 

end 
eig_vals = eigvals(ham)

print(eig_vals[1]," ",eig_vals[2])
#= 
using LinearAlgebra

eig_vals = eigvals(ham)
eig_vecs = eigvecs(ham)

print(eig_vals)

base_st = []

print(eig_vals[1])


for i = 1:n 
    append!(base_st, eig_vecs[i,1])
end 

print(base_st)

print(eig)
=# 