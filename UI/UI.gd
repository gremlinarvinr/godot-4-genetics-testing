extends HBoxContainer

var father_name_label 
var mother_name_label
var selected_name_label
var father_pheno_label
var mother_pheno_label
var father_geno_label
var mother_geno_label
var selected_age_label
var selected_gender_label
var selected_pheno_label
var selected_geno_label

var father_pat_g_fath_lab
var father_pat_g_moth_lab
var father_mat_g_fath_lab
var father_mat_g_moth_lab
var father_father_lab
var father_mother_lab

var mother_pat_g_fath_lab
var mother_pat_g_moth_lab
var mother_mat_g_fath_lab
var mother_mat_g_moth_lab
var mother_father_lab
var mother_mother_lab

var _panel
var selected_pat_g_fath_lab
var selected_pat_g_moth_lab
var selected_mat_g_fath_lab
var selected_mat_g_moth_lab
var selected_father_lab
var selected_mother_lab

# TO DO
# mother, father, grand parents

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("_select_creature", _on_creature_select_creature)
	SignalBus.connect("_update_creature_box", _on_update_creature_box)
	
	father_name_label = self.get_node("Father").get_node("Panel").get_node("FatherNameLabel")
	mother_name_label = self.get_node("Mother").get_node("Panel").get_node("MotherNameLabel")
	selected_name_label = self.get_node("Selected").get_node("Panel").get_node("SelectedNameLabel")
	father_name_label.add_theme_font_size_override("bold_font_size", 24)
	mother_name_label.add_theme_font_size_override("bold_font_size", 24)
	selected_name_label.add_theme_font_size_override("bold_font_size", 24)
	father_pheno_label = self.get_node("Father").get_node("FatherPhenoLabel")
	mother_pheno_label = self.get_node("Mother").get_node("MotherPhenoLabel")
	selected_pheno_label = self.get_node("Selected").get_node("SelectedPhenoLabel")
	father_geno_label = self.get_node("Father").get_node("FatherGenoLabel")
	mother_geno_label = self.get_node("Mother").get_node("MotherGenoLabel")
	selected_geno_label = self.get_node("Selected").get_node("SelectedGenoLabel")
	
	selected_age_label = self.get_node("Selected").get_node("SelectedAgeLabel")
	selected_age_label.add_theme_font_size_override("normal_font_size", 22)
	selected_gender_label = self.get_node("Selected").get_node("SelectedGenderLabel")
	selected_gender_label.add_theme_font_size_override("normal_font_size", 22)

	father_father_lab = self.get_node("Father").get_node("Panel").get_node("FatherFatherLabel")
	father_mother_lab = self.get_node("Father").get_node("Panel").get_node("FatherMotherLabel")
	father_pat_g_fath_lab = self.get_node("Father").get_node("Panel").get_node("FatherPatGFathLab")
	father_pat_g_moth_lab = self.get_node("Father").get_node("Panel").get_node("FatherPatGMothLab")
	father_mat_g_fath_lab = self.get_node("Father").get_node("Panel").get_node("FatherMatGFathLab")
	father_mat_g_moth_lab = self.get_node("Father").get_node("Panel").get_node("FatherMatGMothLab")
	
	mother_father_lab = self.get_node("Mother").get_node("Panel").get_node("MotherFatherLabel")
	mother_mother_lab = self.get_node("Mother").get_node("Panel").get_node("MotherMotherLabel")
	mother_pat_g_fath_lab = self.get_node("Mother").get_node("Panel").get_node("MotherPatGFathLab")
	mother_pat_g_moth_lab = self.get_node("Mother").get_node("Panel").get_node("MotherPatGMothLab")
	mother_mat_g_fath_lab = self.get_node("Mother").get_node("Panel").get_node("MotherMatGFathLab")
	mother_mat_g_moth_lab = self.get_node("Mother").get_node("Panel").get_node("MotherMatGMothLab")
	
	selected_father_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedFatherLabel")
	selected_mother_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedMotherLabel")
	selected_pat_g_fath_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedPatGFathLab")
	selected_pat_g_moth_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedPatGMothLab")
	selected_mat_g_fath_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedMatGFathLab")
	selected_mat_g_moth_lab = self.get_node("Selected").get_node("Panel").get_node("SelectedMatGMothLab")

	_panel = self.get_node("Selected").get_node("Panel")
	_panel.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_update_creature_box(parent):
	var _readable_geno
	if parent == "FATHER":
		father_name_label.set_text("[center][b]" + str(GlobalVariables.currentFather.name) + "[/b][/center]")
		father_pheno_label.set_text("Phenotype: " + str(GlobalVariables.currentFather.color_phenotype).to_lower())
		_readable_geno = _readable_genes(GlobalVariables.currentFather.black_locus)
		father_geno_label.set_text("Genotype: " + _readable_geno)
		father_father_lab.set_text(GlobalVariables.currentFather.father_name)
		father_mother_lab.set_text(GlobalVariables.currentFather.mother_name)
		father_pat_g_fath_lab.set_text(GlobalVariables.currentFather.paternal_father_name)
		father_pat_g_moth_lab.set_text(GlobalVariables.currentFather.paternal_mother_name)
		father_mat_g_fath_lab.set_text(GlobalVariables.currentFather.maternal_father_name)
		father_mat_g_moth_lab.set_text(GlobalVariables.currentFather.maternal_mother_name)
		
	if parent == "MOTHER":
		mother_name_label.set_text("[center][b]" + str(GlobalVariables.currentMother.name) + "[/b][/center]")
		mother_pheno_label.set_text("Phenotype: " + str(GlobalVariables.currentMother.color_phenotype).to_lower())
		_readable_geno = _readable_genes(GlobalVariables.currentMother.black_locus)
		mother_geno_label.set_text("Genotype: " + _readable_geno)
		mother_father_lab.set_text(GlobalVariables.currentMother.father_name)
		mother_mother_lab.set_text(GlobalVariables.currentMother.mother_name)
		mother_pat_g_fath_lab.set_text(GlobalVariables.currentMother.paternal_father_name)
		mother_pat_g_moth_lab.set_text(GlobalVariables.currentMother.paternal_mother_name)
		mother_mat_g_fath_lab.set_text(GlobalVariables.currentMother.maternal_father_name)
		mother_mat_g_moth_lab.set_text(GlobalVariables.currentMother.maternal_mother_name)
		
		
func _on_creature_select_creature():
	if GlobalVariables.selectedCreature != GlobalVariables.currentFather && GlobalVariables.selectedCreature != GlobalVariables.currentMother:		
		selected_name_label.show()
		selected_name_label.set_text("[center][b]" + str(GlobalVariables.selectedCreature.name) + "[/b][/center]")
		selected_age_label.show()
		selected_age_label.set_text("[center]" + str(GlobalVariables.selectedCreature.age).to_pascal_case() + "[/center]")
		selected_gender_label.show()
		if GlobalVariables.selectedCreature.gender == "MALE":
			selected_gender_label.set_text("[center]♂️[/center]")
		else:
			selected_gender_label.set_text("[center]♀️[/center]")
		selected_pheno_label.show()
		selected_pheno_label.set_text("Phenotype: " + str(GlobalVariables.selectedCreature.color_phenotype).to_lower())
		selected_geno_label.show()
		var _readable_geno = _readable_genes(GlobalVariables.selectedCreature.black_locus)
		selected_geno_label.set_text("Genotype: " + _readable_geno)
		
		_panel.show()
		selected_father_lab.set_text(GlobalVariables.selectedCreature.father_name)
		selected_mother_lab.set_text(GlobalVariables.selectedCreature.mother_name)
		selected_pat_g_fath_lab.set_text(GlobalVariables.selectedCreature.paternal_father_name)
		selected_pat_g_moth_lab.set_text(GlobalVariables.selectedCreature.paternal_mother_name)
		selected_mat_g_fath_lab.set_text(GlobalVariables.selectedCreature.maternal_father_name)
		selected_mat_g_moth_lab.set_text(GlobalVariables.selectedCreature.maternal_mother_name)
	else:
		selected_name_label.hide()
		selected_age_label.hide()
		selected_gender_label.hide()
		selected_pheno_label.hide()
		selected_geno_label.hide()
		
		_panel.hide()
	
func _readable_genes(black_locus):
	var _readable_array = []
	# black_locus, remember to ` after each locus :)
	for i in 2:
		if black_locus[i] == "BLACK":
			_readable_array.push_back("B")
		elif black_locus[i] == "GRAY":
			_readable_array.push_back("b")
		elif black_locus[i] == "WHITE":
			_readable_array.push_back("b[sup]w[/sup]")
	var _readable = "".join(_readable_array)
	return _readable
	
