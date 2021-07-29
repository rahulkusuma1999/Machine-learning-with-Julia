using CSV
using DataFrames


using StatsBase
using Statistics

using Gadfly

using DataStructures

df = CSV.read("athlete_events.csv");


last(df,10)

df[:Season]

#df2 = CSV.read("noc_regions.csv");
#first(df2,10)

@show size(df)
#@show size(df2)

countmap(df[:Season])


names(df);


using DataFramesMeta

winter = @where(df, :Season .== "Winter");

summer = @where(df, :Season .== "Summer");

using Plots

summer = DataFrame(summer);
winter = DataFrame(winter);

names(df);
x=sort(countmap(df[:Team]))
s = sort!(collect(x), by=p->p[2],rev=true)
d = DataFrame(s)
ten=first(d,10)
bar(ten[:first],ten[:second])

ten |> @vlplot(
    theta={:second, stack=true},
    color={"first:n", legend=nothing},
    view={stroke=nothing}) +
@vlplot(mark={:arc, outerRadius=150}) +
@vlplot(mark={:text, radius=190}, text="first:n")

countmap(df[:Medal])


df2  =  df[df.Medal .!="NA",:]



using DataStructures

x=sort(countmap(summer[!,:Sport]))
s =DataFrame(sort!(OrderedDict(x), byvalue=true, rev=true))



basketball = DataFrame(@where(summer , :Sport .== "Basketball" ))
bas  = basketball[:Height]
bas = bas[bas.!="NA",:]
bas = parse.(Int64,bas[:,:])
ceil(mean(bas))

bas = summer[summer[:Height].!="NA",:]

height = groupby(bas,:Sport)
#combine(height , :Height => mean)

bas[:height] = [parse(Int,x) for x in bas[:Height]] 

typeof(bas[:height])

df = combine(height , :height => mean)


df[:height_mean]=ceil.(df[:height_mean])



#df[:height_mean_ceil] = [parse(Int,x) for x in df[:height_mean]] 



using Plots

#barh(df[:Sport],df[:height_mean])

using Vega
#barplot(x = df[:Sport], y =df[:height_mean] , horizontal = true)

using VegaLite

@vlplot(
    height={step=25},
    width=750,
    :bar,
    y=df[:Sport],
    x=df[:height_mean],
)

bas = winter[winter[:Height].!="NA",:]
height = groupby(bas,:Sport)
bas[:height] = [parse(Int,x) for x in bas[:Height]] 
df = combine(height , :height => mean)
df[:height_mean]=ceil.(df[:height_mean])
@vlplot(
    height={step=25},
    width=750,
    :bar,
    y=df[:Sport],
    x=df[:height_mean]
)

countmap(summer[:Sport])

swimming = @where(summer, :Sport .== "Swimming")

bas = swimming[swimming[:Medal].!="NA",:]
men = @where(bas, :Sex .== "M")
women = @where(bas, :Sex .== "F")
#df = groupby(bas,:Team)
#df = combine(df,:Medal => countmap)
d = countmap(men[:Team])
s = sort!(collect(d), by=p->p[2],rev=true)
d = DataFrame(s)
ten= first(d,10)


pyplot()

bar(ten[:first],ten[:second])

@vlplot(
    height={step=25},
    width=750,
    :bar,
    
    x=ten[:second],
    y=ten[:first]
)



ten |> @vlplot(
    theta={:second, stack=true},
    color={"first:n", legend=nothing},
    view={stroke=nothing}) +
@vlplot(mark={:arc, outerRadius=150}) +
@vlplot(mark={:text, radius=190}, text="first:n")

d = countmap(women[:Team])
s = sort!(collect(d), by=p->p[2],rev=true)
d = DataFrame(s)
ten= first(d,10)

bar(ten[:first],ten[:second])

ten |> @vlplot(
    theta={:second, stack=true},
    color={"first:n", legend=nothing},
    view={stroke=nothing}) +
@vlplot(mark={:arc, outerRadius=150}) +
@vlplot(mark={:text, radius=190}, text="first:n")

@vlplot(
    height={step=25},
    width=750,
    :bar,
    
    x=ten[:second],
    y=ten[:first]
)

d = countmap(bas[:Name])
s = sort!(collect(d), by=p->p[2],rev=true)
d = DataFrame(s)
tenn= first(d,10)
bar(tenn[:first],tenn[:second])

@vlplot(
    height={step=25},
    width=750,
    :bar,
    
    x=tenn[:second],
    y=tenn[:first]
)

tenn |> @vlplot(
    theta={:second, stack=true},
    color={"first:n", legend=nothing},
    view={stroke=nothing}) +
@vlplot(mark={:arc, outerRadius=150}) +
@vlplot(mark={:text, radius=220}, text="first:n")

names(bas)

#violin(bas[:Height],bas[:Weight])

bas[:Games]

scatter(bas[:Weight],bas[:Height])

women |> @vlplot(
    transform=[{filter="datum.symbol==='Weight'"}],
    mark={
        :line,
        point=true
    },
    x=:Year,
    y=:Weight,
    color=:symbol
)

scatter(women[:Year],women[:Weight])

#Geom.point(women[:Year],women[:Weight])


