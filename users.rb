users =  {

 "Angelica" => {"Blues Traveler" => 3.5, "Broken Bells"=> 2.0, "Norah Jones"=> 4.5, "Phoenix"=> 5.0,
 "Slightly Stoopid"=> 1.5,
 "The Strokes"=> 2.5, "Vampire Weekend"=> 2.0},

 "Bill"=> {"Blues Traveler"=> 2.0, "Broken Bells"=> 3.5,
 "Deadmau5"=> 4.0, "Phoenix"=> 2.0,
 "Slightly Stoopid"=> 3.5, "Vampire Weekend"=> 3.0},

 "Chan"=> {"Blues Traveler"=> 5.0, "Broken Bells"=> 1.0,
 "Deadmau5"=> 1.0, "Norah Jones"=> 3.0,
 "Phoenix"=> 5, "Slightly Stoopid"=> 1.0},

 "Dan"=> {"Blues Traveler"=> 3.0, "Broken Bells"=> 4.0,
 "Deadmau5"=> 4.5, "Phoenix"=> 3.0,
 "Slightly Stoopid"=> 4.5, "The Strokes"=> 4.0,
 "Vampire Weekend"=> 2.0},

 "Hailey"=> {"Broken Bells"=> 4.0, "Deadmau5"=> 1.0,
 "Norah Jones"=> 4.0, "The Strokes"=> 4.0,
 "Vampire Weekend"=> 1.0},

 "Jordyn"=> {"Broken Bells"=> 4.5, "Deadmau5"=> 4.0, "Norah Jones"=> 5.0,
 "Phoenix"=> 5.0, "Slightly Stoopid"=> 4.5,
 "The Strokes"=> 4.0, "Vampire Weekend"=> 4.0},

 "Sam"=> {"Blues Traveler"=> 5.0, "Broken Bells"=> 2.0,
 "Norah Jones"=> 3.0, "Phoenix"=> 5.0,
 "Slightly Stoopid"=> 4.0, "The Strokes"=> 5.0},

 "Veronica"=> {"Blues Traveler"=> 3.0, "Norah Jones"=> 5.0,
 "Phoenix"=> 4.0, "Slightly Stoopid"=> 2.5,
 "The Strokes"=> 3.0},

 "Clara" => {"Blues Traveler" => 4.75, "Norah Jones" => 4.5, "Phoenix" => 5, "The Strokes" => 4.25, "Weird Al" => 4},
 "Robert" => {"Blues Traveler" => 4, "Norah Jones" => 3, "Phoenix" => 5, "The Strokes" => 2, "Weird Al" => 1}
}

def minkowski(rating1, rating2, r)
	# computes Minkowski distance. rating1 and rating 2 are hashes. r can be 1 or 2. 1 is manhattan distance, 2 is euclidian
	# hashes are in the form {"Norah Jones" => 3.0, "Phoenix" => 5.0...}

	distance = 0
	commonRatings = false

	rating1.keys.each do |artist|
 		if rating2.has_key? artist
 			distance += 
 					((rating1[artist] - rating2[artist]).abs) ** r
 			commonRatings = true
 		end
 	end
if commonRatings == true
 		return distance ** (1/r)
 	else
 		return 0
 	end

end

 def manhattan(rating1, rating2)
 	# calculates the Manhattan distance on matched ratings across 2 hashes (rating1 and rating2)
 	# hashes are in the form {"Norah Jones" => 3.0, "Phoenix" => 5.0...}

 	distance = 0

 	rating1.each do |k, v|
 		if rating2.has_key? k
 			distance += (v - rating2[k]).abs
 		end
 		
 	end

 	return distance

 end

 puts "manhattan distance between Hailey and Veronica is " + (manhattan(users["Hailey"], users["Veronica"])).to_s
 puts "manhattan distance between Hailey and Jordyn is " + (manhattan(users["Hailey"], users["Jordyn"])).to_s

 def compute_nearest_neighbor(username, users)
 	# creates a sorted array of neighbors and distances from a given user. Closest neighbor is the first value

 	distances = Array.new

 	users.keys.each do |user|
 		if user != username
 			distance = minkowski(users[user], users[username], 1)
 			distances << [distance, user]

 		end

 	end

 	return distances.sort

 end


 print "Hailey's nearest neighbors : " + (compute_nearest_neighbor("Hailey", users)).to_s
 # puts compute_nearest_neighbor("Hailey", users).first 

 def recommend(username, users)
 	#makes recommendations for a user
 	#get the nearest neighbor first

 	nearest = compute_nearest_neighbor(username, users).first[1]
 	puts "nearest is " + nearest.to_s

 	#now find bands neighbor rated, but user did not

 	neighbor_ratings = users[nearest]
 	user_ratings = users[username]

 	recommendations = Array.new

 	neighbor_ratings.keys.each do |artist|
 		if !user_ratings.has_key? artist
 			recommendations << [artist, neighbor_ratings[artist]]
 		end
	end

	recommendations.sort_by! { |x,y| y }
	return recommendations.reverse!

 end

puts ""
print "Recommedations for Hailey : " + (recommend("Hailey", users)).to_s
puts ""

puts ""
print "Recommedations for Sam : " + (recommend("Sam", users)).to_s
puts ""

def pearson(rating1, rating2)
	#calculates the pearson correlation coefficient between two hashes of music artist ratings

	number_of_bands_in_common = 0

	first_expression = 0
	rest_of_numerator = 0

	first_part_of_denominator = 0
	second_part_of_denominator = 0
	third_part_of_denominator = 0
	fourth_part_of_denominator = 0

	rating1_sum = 0
	rating2_sum = 0

	rating1.keys.each do |artist|
		if rating2.has_key? artist
			number_of_bands_in_common += 1
			rating1_sum += rating1[artist]
			rating2_sum += rating2[artist]
			first_expression += (rating1[artist] * rating2[artist])
			first_part_of_denominator += rating1[artist] ** 2

			third_part_of_denominator += rating2[artist] ** 2
			
		end
	end

	rest_of_numerator = (rating1_sum * rating2_sum) / number_of_bands_in_common

	second_part_of_denominator += (rating1_sum ** 2) / number_of_bands_in_common
	fourth_part_of_denominator += (rating2_sum ** 2) / number_of_bands_in_common

	numerator = (first_expression - rest_of_numerator).abs
	puts "rating1_sum = " + rating1_sum.to_s
	puts "rating2_sum = " +rating2_sum.to_s
	puts "number_of_bands_in_common = " + number_of_bands_in_common.to_s
	puts "first_expression = " + first_expression.to_s
	puts "rest_of_numerator = " + rest_of_numerator.to_s
	puts "numerator = " + numerator.to_s
	puts "first_part_of_denominator = " + first_part_of_denominator.to_s
	puts "second_part_of_denominator = " + second_part_of_denominator.to_s
	puts "third_part_of_denominator = " + third_part_of_denominator.to_s
	puts "fourth_part_of_denominator = " + fourth_part_of_denominator.to_s
	denominator = Math.sqrt((first_part_of_denominator - second_part_of_denominator).abs) * Math.sqrt((third_part_of_denominator - fourth_part_of_denominator).abs)

	r = numerator / denominator

	puts "numerator = " + numerator.to_s
	puts "denominator = " + denominator.to_s
	puts "Pearson Correlatoon coefficient = " + r.to_s

end

pearson(users["Angelica"], users["Jordyn"])





