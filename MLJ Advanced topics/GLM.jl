### A Pluto.jl notebook ###
# v0.11.13

using Markdown
using InteractiveUtils

# ╔═╡ 5356ece0-ffc4-11ea-181e-c5b7b11e0a85
using CategoricalArrays ,PrettyPrinting

# ╔═╡ 73a9ddc0-ffe4-11ea-232c-a1273415a33a
using MLJ

# ╔═╡ 9ac2c4f0-ffc4-11ea-0e17-057a9f0b90d4
using UrlDownload


# ╔═╡ 8c6f78d2-ffc4-11ea-3712-f50441591c45
import DataFrames:DataFrame,nrow

# ╔═╡ 9a882cf0-ffc4-11ea-3e3f-0f43709988c2
begin
@load LinearRegressor  pkg = GLM
@load LinearBinaryClassifier pkg=GLM
end

# ╔═╡ 99e2c532-ffc4-11ea-14a9-ddbcfa169f34
baseurl = "https://raw.githubusercontent.com/tlienart/DataScienceTutorialsData.jl/master/data/glm/"

# ╔═╡ 993e47d0-ffc4-11ea-357f-1543bdc08d85
begin
dfX = DataFrame(urldownload(baseurl*"X3.csv"))
dfYbinary = DataFrame(urldownload(baseurl * "Y3.csv"))
dfX1 = DataFrame(urldownload(baseurl * "X1.csv"))
dfY1 = DataFrame(urldownload(baseurl * "Y1.csv"));
end

# ╔═╡ b4e10f30-ffc5-11ea-305c-5bcf746fba67
first(dfX,3)

# ╔═╡ b4a369f0-ffc5-11ea-08b4-75caae43eeec
first(dfY1,3)

# ╔═╡ aceddbf0-ffe3-11ea-2fbe-77e8ef702d56
X = copy(dfX1)

# ╔═╡ bd40efb0-ffe3-11ea-28ea-c9dc6f9a83f3
y=copy(dfY1)

# ╔═╡ aca75d10-ffe3-11ea-0cb1-9f681bcf66ef
begin
X1=coerce(X, autotype(X, :string_to_multiclass))
yv = Vector(y[:, 1])
end


# ╔═╡ aca53a30-ffe3-11ea-3067-b3b3a93e49c1

LinearRegressorPipe = LinearRegressor()

# ╔═╡ aca27b10-ffe3-11ea-30b6-c185fb50f29e
LinearModel = machine(LinearRegressorPipe, X1, yv)

# ╔═╡ ac49d3c2-ffe3-11ea-06a8-e9b6b65b2d8e
fit!(LinearModel)

# ╔═╡ b933cf10-ffe7-11ea-0aa0-b9e0565ca0d0
fp  = fitted_params(LinearModel)

# ╔═╡ b8fe6730-ffe7-11ea-38ac-a1261188246a
begin
ŷ = MLJ.predict(LinearModel, X)
yhatResponse = [ŷ[i,1].μ for i in 1:nrow(y)]
residuals = y .- yhatResponse
r = report(LinearModel)
end

# ╔═╡ b8d27530-ffe7-11ea-2f7f-e90780748dc3
round(rms(yhatResponse, y[:,1]), sigdigits=4)


# ╔═╡ Cell order:
# ╠═5356ece0-ffc4-11ea-181e-c5b7b11e0a85
# ╠═73a9ddc0-ffe4-11ea-232c-a1273415a33a
# ╠═8c6f78d2-ffc4-11ea-3712-f50441591c45
# ╠═9ac2c4f0-ffc4-11ea-0e17-057a9f0b90d4
# ╠═9a882cf0-ffc4-11ea-3e3f-0f43709988c2
# ╠═99e2c532-ffc4-11ea-14a9-ddbcfa169f34
# ╠═993e47d0-ffc4-11ea-357f-1543bdc08d85
# ╠═b4e10f30-ffc5-11ea-305c-5bcf746fba67
# ╠═b4a369f0-ffc5-11ea-08b4-75caae43eeec
# ╠═aceddbf0-ffe3-11ea-2fbe-77e8ef702d56
# ╠═bd40efb0-ffe3-11ea-28ea-c9dc6f9a83f3
# ╠═aca75d10-ffe3-11ea-0cb1-9f681bcf66ef
# ╠═aca53a30-ffe3-11ea-3067-b3b3a93e49c1
# ╠═aca27b10-ffe3-11ea-30b6-c185fb50f29e
# ╠═ac49d3c2-ffe3-11ea-06a8-e9b6b65b2d8e
# ╠═b933cf10-ffe7-11ea-0aa0-b9e0565ca0d0
# ╠═b8fe6730-ffe7-11ea-38ac-a1261188246a
# ╠═b8d27530-ffe7-11ea-2f7f-e90780748dc3
