extends Node
signal create_baby(black_locus, color)

func _on_main_breed(father, mother):
	print("-- NEW BABY --")
	print("father: " + father.name + " mother: " + mother.name)
	
	var gender: String

	# from here we need to compare them based on the relationship between the alleles
	# same number value = co-dominant or incomplete dominance, special cases will need to be programmed in
	# lower number value = dominant over the higher number (the reason i'm doing it this way is for my sanity as i write down the genes from order of dominant to recessive)
	# and then we retrieve the genotype and then the phenotype color for this locus
	
	var _combos = _compare_genes(father.black_locus, mother.black_locus).pick_random()
	var black_locus = _combos[0]
	var black_pheno = _combos[1]
	
	# HERE IS WHERE WE WILL DETERMINE FINAL COLOR/PATTERN VIA A HIERARCHY FUNCTION but we don't do that yet :3
	var color: Color
	var color_phenotype: String
	if black_pheno == "BLACK": 
		color = GlobalVariables.black_modulation
	elif black_pheno == "GRAY":
		color = GlobalVariables.gray_modulation
	elif black_pheno == "WHITE":
		color = GlobalVariables.white_modulation
	color_phenotype = black_pheno
	
	# determine gender (for sex-linked traits, you would use that to determine gender)
	var _gender_rng = randi_range(0,1)
	if _gender_rng == 0:
		gender = "MALE"
	else:
		gender = "FEMALE"
		
	# and finally: create the baby! welcome to the world littol guy ,,
	create_baby.emit(black_locus, color_phenotype, color, gender)
	
	
func _compare_genes(father_genes, mother_genes):
	# this is where we hold the baby's possibilities 
	var _combos = []
	
	# first we have to keep in mind that there are 4 combinations and so we need to do 1a x 2a & 1a x 2b before moving on to 1b x 2a & 1b x 2b :3
	# secondly, we need a way to retrieve the information from the dictionary on the allele relationships ...
	# thirdly i'm typing this at 2:16 am pray for me that i will understand this come morning 
	# fourthly: one day we will cross the bridge of non strictly dominant/recessive relationships
	# oh yeah and fifthly: we need to also grab the expressed trait here to be most efficient ! we will split up the array later :)
	for i in 2:
		for x in 2:
			print("Combo: " + str(i) + "-" + str(x) + " - father gene: " + father_genes[i] + " - mother gene: " + mother_genes[x])
			# check if the gene is the same :)
			if father_genes[i] == mother_genes[x]:
				print("-- Father and mother had same allele:" + str(father_genes[i]))
				_combos.push_back([[father_genes[i], mother_genes[x]], father_genes[i]])
			else:
				# father's allele is dominant
				if GlobalVariables.black_locus_dict.find_key(father_genes[i]) < GlobalVariables.black_locus_dict.find_key(mother_genes[x]):
					print("-- Father's allele is dominant:" + str([father_genes[i], mother_genes[x]]))
					_combos.push_back([[father_genes[i], mother_genes[x]], father_genes[i]])
				# mother's allele is dominant
				elif GlobalVariables.black_locus_dict.find_key(father_genes[i]) > GlobalVariables.black_locus_dict.find_key(mother_genes[x]):
					_combos.push_back([[mother_genes[x], father_genes[i]], mother_genes[x]])
					print("-- Mother's allele is dominant:" + str([mother_genes[x], father_genes[i]]))
				# alleles are co-dominant/incompletely dominant (code in later)
				elif GlobalVariables.black_locus_dict.find_key(father_genes[i] == GlobalVariables.black_locus_dict.find_key(mother_genes[x])):
					print("-- Co-dominance/incomplete dominance:" + str([father_genes[i], mother_genes[x]]))
					# THE EXPRESSED TRAIT WILL HAVE TO BE FIGURED OUT VIA DICT WITHIN A DICT MAYBE??? idk lets just not do it rn tho
					_combos.push_back([father_genes[i], mother_genes[x]])
				else:
					print("-- Error: Could not determine the relationship between these alleles:" + str([father_genes[i], mother_genes[x]]))
	return _combos
