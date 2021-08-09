### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ a0240690-f797-11eb-37f1-e51cf1693a40
using CSV,DataFrames

# ╔═╡ 81a69da0-f214-11eb-1abc-87df2e68b01e
begin
	
	using VegaLite
	
end

# ╔═╡ 2c6a6af0-f83c-11eb-2929-e96d4946731b
using StatsBase

# ╔═╡ 791e81e0-f81b-11eb-1ccd-131c2484266a
using PlutoUI

# ╔═╡ 8b7d84b0-f83b-11eb-07ad-d5e3ab59fc84
using DataFramesMeta


# ╔═╡ 81a62870-f214-11eb-1251-111561bcd433
hdi = CSV.read("C:/Users/Rahul/Desktop/julia/olympic/Book1.csv")

# ╔═╡ 81a5da50-f214-11eb-3eae-df3f00172ca2
NOC = CSV.read("C:/Users/Rahul/Desktop/julia/olympic/noc_regions.csv"); NOC=DataFrame(NOC)

# ╔═╡ 00d28f60-f76c-11eb-1e68-434b64ac50f3
NOC

# ╔═╡ 81598f10-f214-11eb-1347-6351997ffb15
df = DataFrame(CSV.File("C:/Users/Rahul/Desktop/julia/olympic/athlete_events.csv"))

# ╔═╡ 2e3da900-f215-11eb-2006-0dc8ce53c549
df.MedalCount = replace(df.Medal,"NA" => 0)

# ╔═╡ 2dd23d00-f215-11eb-161d-abd6fa687a12
begin
	df.MedalCount = replace(df.MedalCount,"Gold" => 1)
	df.MedalCount = replace(df.MedalCount,"Silver" => 1)
	df.MedalCount = replace(df.MedalCount,"Bronze" => 1)
end

# ╔═╡ d9e4d050-f27c-11eb-1436-732711b59b50
countmap(df[:MedalCount])

# ╔═╡ 52ceb460-f217-11eb-1e37-11a3671f7617
medalcountsum=combine(groupby(df,  :NOC), :MedalCount => sum)

# ╔═╡ d561d420-f217-11eb-07a9-75ae892fe7f9
md"""
if we see USA is the best performing country in olympics followed by USSR And GERMANY


"""

# ╔═╡ 528f1350-f217-11eb-0a1e-cf943a21fe0e
begin
	sorted= sort(medalcountsum,:MedalCount_sum,rev=true)
	ten=first(sorted,10)
end

# ╔═╡ 89f7d6f0-f218-11eb-3a27-d375a3d571c5
md""""
creating a wheel function
"""

# ╔═╡ 51e7fde0-f217-11eb-3409-938544530716
wheel(ten,ten[:NOC],ten[:MedalCount_sum])

# ╔═╡ 51843300-f217-11eb-1bbf-b713e3088013
bar(ten[:NOC],ten[:MedalCount_sum])

# ╔═╡ d58818d0-f751-11eb-1766-e3f32f274e9e
select!(NOC, Not(:notes))

# ╔═╡ d54850b0-f751-11eb-3034-31261fd0877e
begin
	df1 = join(df, NOC; on = :NOC, kind = :left, makeunique = false,
     indicator = nothing, validate = (false, false))
end

# ╔═╡ 3c50f690-f752-11eb-0818-d9d4744cd66c
names(df1)

# ╔═╡ fb15fde0-f81b-11eb-0cba-75c7d0beea01
begin
	ENV["COLUMNS"]=1000
	ENV["LINES"] = 50
end

# ╔═╡ f1eb4a50-f860-11eb-3f3d-b90fe27f303b
df2 = df1[ismissing.(df1[:region]), :]

# ╔═╡ 396f6550-f861-11eb-168f-79b970b79b81
countmap(df2[:Team])

# ╔═╡ 938adec0-f861-11eb-342c-47dfe73df999


# ╔═╡ 934ec022-f861-11eb-0f31-01e36987efa4


# ╔═╡ 931f4bb0-f861-11eb-199f-e16382c70f25


# ╔═╡ 92f02560-f861-11eb-0928-29e788b1455a


# ╔═╡ 92c089e0-f861-11eb-0198-6199e8ecb461


# ╔═╡ Cell order:
# ╠═a0240690-f797-11eb-37f1-e51cf1693a40
# ╠═81a69da0-f214-11eb-1abc-87df2e68b01e
# ╠═2c6a6af0-f83c-11eb-2929-e96d4946731b
# ╠═81a62870-f214-11eb-1251-111561bcd433
# ╠═81a5da50-f214-11eb-3eae-df3f00172ca2
# ╠═00d28f60-f76c-11eb-1e68-434b64ac50f3
# ╠═81598f10-f214-11eb-1347-6351997ffb15
# ╠═2e3da900-f215-11eb-2006-0dc8ce53c549
# ╠═2dd23d00-f215-11eb-161d-abd6fa687a12
# ╠═d9e4d050-f27c-11eb-1436-732711b59b50
# ╠═52ceb460-f217-11eb-1e37-11a3671f7617
# ╟─d561d420-f217-11eb-07a9-75ae892fe7f9
# ╠═528f1350-f217-11eb-0a1e-cf943a21fe0e
# ╟─89f7d6f0-f218-11eb-3a27-d375a3d571c5
# ╟─51e7fde0-f217-11eb-3409-938544530716
# ╠═51843300-f217-11eb-1bbf-b713e3088013
# ╠═d58818d0-f751-11eb-1766-e3f32f274e9e
# ╠═d54850b0-f751-11eb-3034-31261fd0877e
# ╠═3c50f690-f752-11eb-0818-d9d4744cd66c
# ╠═fb15fde0-f81b-11eb-0cba-75c7d0beea01
# ╠═791e81e0-f81b-11eb-1ccd-131c2484266a
# ╠═8b7d84b0-f83b-11eb-07ad-d5e3ab59fc84
# ╠═f1eb4a50-f860-11eb-3f3d-b90fe27f303b
# ╠═396f6550-f861-11eb-168f-79b970b79b81
# ╠═938adec0-f861-11eb-342c-47dfe73df999
# ╠═934ec022-f861-11eb-0f31-01e36987efa4
# ╠═931f4bb0-f861-11eb-199f-e16382c70f25
# ╠═92f02560-f861-11eb-0928-29e788b1455a
# ╠═92c089e0-f861-11eb-0198-6199e8ecb461
