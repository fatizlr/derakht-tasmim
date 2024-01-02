--create database tenis
/*create table tenis ( outlook nvarchar(30) , temperature nvarchar(30) , humidity nvarchar(30) , wind nvarchar(30) , playtennis nvarchar(30))
insert into tenis values
('sunny', 'hot', 'high', 'weak', 'no'),
('sunny', 'hot', 'high', 'strong', 'no'),
('overcast', 'hot', 'high', 'weak', 'yes'),
('rain', 'mild', 'high', 'weak', 'yes'),
('rain', 'cool', 'normal', 'weak', 'yes'),
('rain', 'cool', 'normal', 'strong', 'no'),
('overcast', 'cool', 'normal', 'strong', 'yes'),
('sunny', 'mild', 'high', 'weak', 'no'),
('sunny', 'cool', 'normal', 'weak', 'yes'),
('rain', 'mild', 'normal', 'weak', 'yes'),
('sunny', 'mild', 'normal', 'strong', 'yes'),
('overcast', 'mild', 'high', 'strong', 'yes'),
('overcast', 'hot', 'normal', 'weak', 'yes'),
('rain', 'mild', 'high', 'strong', 'no')*/

--entropy kol

--tedad yes kol
declare @yes int
select @yes = count (*) from tenis where playtennis='yes'
--tedad no kol
declare @no int
select @no = count (*) from tenis where playtennis='no'
--ehtemal yes kol
declare @pyes float
set @pyes =  @yes / cast ((select count (*) from tenis) as float) 
--ehtemal no kol
declare @pno float
set @pno =  @no / cast ((select count (*) from tenis) as float) 
--entropy(s)
declare @entropy_s float
set @entropy_s = (-1*@pyes*(select log(@pyes , 2)))+(-1*@pno*(select log(@pno , 2)))

--entropy(sv)

--tedad yes sunny
declare @sunny_yes int
select @sunny_yes = count (*) from tenis where outlook ='sunny' and playtennis='yes'
--tedad no sunny
declare @sunny_no int
select @sunny_no = count (*) from tenis where outlook ='sunny' and playtennis='no'
--ehtemal yes sunny
declare @p_sunny_yes float
set @p_sunny_yes =  @sunny_yes / cast ((select count (*) from tenis where outlook ='sunny') as float) 
--ehtemal no sunny
declare @p_sunny_no float
set @p_sunny_no =  @sunny_no / cast ((select count (*) from tenis where outlook ='sunny') as float) 
--entropy(sunny)
declare @entropy_sunny float
set @entropy_sunny = (-1*@p_sunny_yes*(select log(@p_sunny_yes , 2)))+(-1*@p_sunny_no*(select log(@p_sunny_no , 2)))
--zarib(sunny)
declare @zarib_sunny float;
select @zarib_sunny = cast ((select count (*) from tenis where outlook ='sunny') as float)  / cast ((select count (*) from tenis) as float) 
declare @sunny float
set @sunny = @zarib_sunny*@entropy_sunny

--tedad yes rain
declare @rain_yes int
select @rain_yes = count (*) from tenis where outlook ='rain' and playtennis='yes'
--tedad no rain
declare @rain_no int
select @rain_no = count (*) from tenis where outlook ='rain' and playtennis='no'
--ehtemal yes rain
declare @p_rain_yes float
set @p_rain_yes =  @rain_yes / cast ((select count (*) from tenis where outlook ='rain') as float) 
--ehtemal no rain
declare @p_rain_no float
set @p_rain_no =  @rain_no / cast ((select count (*) from tenis where outlook ='rain') as float) 
--entropy(rain)
declare @entropy_rain float
set @entropy_rain = (-1*@p_rain_yes*(select log(@p_rain_yes , 2)))+(-1*@p_rain_no*(select log(@p_rain_no , 2)))
--zarib(rain)
declare @zarib_rain float;
select @zarib_rain = cast ((select count (*) from tenis where outlook ='rain') as float)  / cast ((select count (*) from tenis) as float) 
declare @rain float
set @rain = @zarib_rain*@entropy_rain

--tedad yes overcast
declare @overcast_yes int
select @overcast_yes = count (*) from tenis where outlook ='overcast' and playtennis='yes'
--tedad no overcast
declare @overcast_no int
select @overcast_no = count (*) from tenis where outlook ='overcast' and playtennis='no'
--ehtemal yes overcast
declare @p_overcast_yes float
set @p_overcast_yes =  @overcast_yes / cast ((select count (*) from tenis where outlook ='overcast') as float) 
--ehtemal no overcast
declare @p_overcast_no float
set @p_overcast_no = 0 --@overcast_no / cast ((select count (*) from tenis where outlook ='overcast') as float) 
--entropy(overcast)
declare @entropy_overcast float
set @entropy_overcast = (-1*@p_overcast_yes*(select log(@p_overcast_yes , 2)))
--zarib(overcast)
declare @zarib_overcast float;
select @zarib_overcast = cast ((select count (*) from tenis where outlook ='overcast') as float)  / cast ((select count (*) from tenis) as float) 
declare @overcast float
set @overcast = @zarib_overcast*@entropy_overcast

--gain(outlook)
declare @m_outlook float
set @m_outlook=@sunny+@rain+@overcast
declare @gain_outlook float
select @gain_outlook=@entropy_s-@m_outlook
select @gain_outlook

--tedad yes hot
declare @hot_yes int
select @hot_yes = count (*) from tenis where temperature ='hot' and playtennis='yes'
--tedad no hot
declare @hot_no int
select @hot_no = count (*) from tenis where temperature ='hot' and playtennis='no'
--ehtemal yes hot
declare @p_hot_yes float
set @p_hot_yes =  @hot_yes / cast ((select count (*) from tenis where temperature ='hot') as float) 
--ehtemal no hot
declare @p_hot_no float
set @p_hot_no =  @hot_no / cast ((select count (*) from tenis where temperature ='hot') as float) 
--entropy(hot)
declare @entropy_hot float
set @entropy_hot = (-1*@p_hot_yes*(select log(@p_hot_yes , 2)))+(-1*@p_hot_no*(select log(@p_hot_no , 2)))
--zarib(hot)
declare @zarib_hot float;
select @zarib_hot = cast ((select count (*) from tenis where temperature ='hot') as float)  / cast ((select count (*) from tenis) as float) 
declare @hot float
set @hot = @zarib_hot*@entropy_hot

--tedad yes mild
declare @mild_yes int
select @mild_yes = count (*) from tenis where temperature ='mild' and playtennis='yes'
--tedad no mild
declare @mild_no int
select @mild_no = count (*) from tenis where temperature ='mild' and playtennis='no'
--ehtemal yes mild
declare @p_mild_yes float
set @p_mild_yes =  @mild_yes / cast ((select count (*) from tenis where temperature ='mild') as float) 
--ehtemal no mild
declare @p_mild_no float
set @p_mild_no =  @mild_no / cast ((select count (*) from tenis where temperature ='mild') as float) 
--entropy(mild)
declare @entropy_mild float
set @entropy_mild = (-1*@p_mild_yes*(select log(@p_mild_yes , 2)))+(-1*@p_mild_no*(select log(@p_mild_no , 2)))
--zarib(mild)
declare @zarib_mild float;
select @zarib_mild = cast ((select count (*) from tenis where temperature ='mild') as float)  / cast ((select count (*) from tenis) as float) 
declare @mild float
set @mild = @zarib_mild*@entropy_mild

--tedad yes cool
declare @cool_yes int
select @cool_yes = count (*) from tenis where temperature ='cool' and playtennis='yes'
--tedad no cool
declare @cool_no int
select @cool_no = count (*) from tenis where temperature ='cool' and playtennis='no'
--ehtemal yes cool
declare @p_cool_yes float
set @p_cool_yes =  @cool_yes / cast ((select count (*) from tenis where temperature ='cool') as float) 
--ehtemal no cool
declare @p_cool_no float
set @p_cool_no =  @cool_no / cast ((select count (*) from tenis where temperature ='cool') as float) 
--entropy(cool)
declare @entropy_cool float
set @entropy_cool = (-1*@p_cool_yes*(select log(@p_cool_yes , 2)))+(-1*@p_cool_no*(select log(@p_cool_no , 2)))
--zarib(cool)
declare @zarib_cool float;
select @zarib_cool = cast ((select count (*) from tenis where temperature ='cool') as float)  / cast ((select count (*) from tenis) as float) 
declare @cool float
set @cool = @zarib_cool*@entropy_cool

--gain(temperature)
declare @m_temperature float
set @m_temperature=@hot+@mild+@cool
declare @gain_temperature float
select @gain_temperature=@entropy_s-@m_temperature
select @gain_temperature

--tedad yes high
declare @high_yes int
select @high_yes = count (*) from tenis where humidity ='high' and playtennis='yes'
--tedad no high
declare @high_no int
select @high_no = count (*) from tenis where humidity ='high' and playtennis='no'
--ehtemal yes high
declare @p_high_yes float
set @p_high_yes =  @high_yes / cast ((select count (*) from tenis where humidity ='high') as float) 
--ehtemal no high
declare @p_high_no float
set @p_high_no =  @high_no / cast ((select count (*) from tenis where humidity ='high') as float) 
--entropy(high)
declare @entropy_high float
set @entropy_high = (-1*@p_high_yes*(select log(@p_high_yes , 2)))+(-1*@p_high_no*(select log(@p_high_no , 2)))
--zarib(high)
declare @zarib_high float;
select @zarib_high = cast ((select count (*) from tenis where humidity ='high') as float)  / cast ((select count (*) from tenis) as float) 
declare @high float
set @high = @zarib_high*@entropy_high

--tedad yes normal
declare @normal_yes int
select @normal_yes = count (*) from tenis where humidity ='normal' and playtennis='yes'
--tedad no normal
declare @normal_no int
select @normal_no = count (*) from tenis where humidity ='normal' and playtennis='no'
--ehtemal yes normal
declare @p_normal_yes float
set @p_normal_yes =  @normal_yes / cast ((select count (*) from tenis where humidity ='normal') as float) 
--ehtemal no normal
declare @p_normal_no float
set @p_normal_no =  @normal_no / cast ((select count (*) from tenis where humidity ='normal') as float) 
--entropy(normal)
declare @entropy_normal float
set @entropy_normal = (-1*@p_normal_yes*(select log(@p_normal_yes , 2)))+(-1*@p_normal_no*(select log(@p_normal_no , 2)))
--zarib(normal)
declare @zarib_normal float;
select @zarib_normal = cast ((select count (*) from tenis where humidity ='normal') as float)  / cast ((select count (*) from tenis) as float) 
declare @normal float
set @normal = @zarib_normal*@entropy_normal

--gain(humidity)
declare @m_humidity float
set @m_humidity=@high+@normal
declare @gain_humidity float
select @gain_humidity=@entropy_s-@m_humidity
select @gain_humidity

--tedad yes weak
declare @weak_yes int
select @weak_yes = count (*) from tenis where wind ='weak' and playtennis='yes'
--tedad no weak
declare @weak_no int
select @weak_no = count (*) from tenis where wind ='weak' and playtennis='no'
--ehtemal yes weak
declare @p_weak_yes float
set @p_weak_yes =  @weak_yes / cast ((select count (*) from tenis where wind ='weak') as float) 
--ehtemal no weak
declare @p_weak_no float
set @p_weak_no =  @weak_no / cast ((select count (*) from tenis where wind ='weak') as float) 
--entropy(weak)
declare @entropy_weak float
set @entropy_weak = (-1*@p_weak_yes*(select log(@p_weak_yes , 2)))+(-1*@p_weak_no*(select log(@p_weak_no , 2)))
--zarib(weak)
declare @zarib_weak float;
select @zarib_weak = cast ((select count (*) from tenis where wind ='weak') as float)  / cast ((select count (*) from tenis) as float) 
declare @weak float
set @weak = @zarib_weak*@entropy_weak

--tedad yes strong
declare @strong_yes int
select @strong_yes = count (*) from tenis where wind ='strong' and playtennis='yes'
--tedad no strong
declare @strong_no int
select @strong_no = count (*) from tenis where wind ='strong' and playtennis='no'
--ehtemal yes strong
declare @p_strong_yes float
set @p_strong_yes =  @strong_yes / cast ((select count (*) from tenis where wind ='strong') as float) 
--ehtemal no strong
declare @p_strong_no float
set @p_strong_no =  @strong_no / cast ((select count (*) from tenis where wind ='strong') as float) 
--entropy(strong)
declare @entropy_strong float
set @entropy_strong = (-1*@p_strong_yes*(select log(@p_strong_yes , 2)))+(-1*@p_strong_no*(select log(@p_strong_no , 2)))
--zarib(strong)
declare @zarib_strong float;
select @zarib_strong = cast ((select count (*) from tenis where wind ='strong') as float)  / cast ((select count (*) from tenis) as float) 
declare @strong float
set @strong = @zarib_strong*@entropy_strong

--gain(wind)
declare @m_wind float
set @m_wind=@weak+@strong
declare @gain_wind float
select @gain_wind=@entropy_s-@m_wind
select @gain_wind

--rishe derakht
if @gain_outlook > @gain_temperature
	begin
	declare @max1 float
	set @max1 = @gain_outlook
	end
else
	begin
	set @max1 = @gain_temperature
	end
if @gain_humidity > @gain_wind
	begin
	declare @max2 float
	set @max2 = @gain_humidity
	end
else
	begin
	set @max2 = @gain_wind
	end
if @max1 > @max2
	begin
	declare @max float
	set @max = @max1
	select @max
	end
else
	begin
	set @max = @max2
	select @max
	end