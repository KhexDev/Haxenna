package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_funkin_bold_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_funkin_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_pixel_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_vcr_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		Assets.libraryPaths["default"] = rootPath + "manifest/default.json";
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_50_ways_to_say_goodbye_sm_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_crazylittlelove_sm_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_50_ways_to_say_goodbye_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_7__seven__sm_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_7seven_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_accelerant_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_ballistic_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_ballistic_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_blazeborn_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_blazeborn_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_blocked_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_blocked_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_boogie_man_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_boxing_match_voiid_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_burnout_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_bushwhack_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_bushwhack_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_corn_theft_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_cough_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_cough_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_crazylittlelove_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_dadbattle_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_dadbattle_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_danger_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_death_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_detected_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_dilan_noises_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_dilan_noises_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_disruption_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_endless_battle_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_expurgation_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_final_draft_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_finale_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_flippin_out_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_foolhardy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_galaxy_collapse_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_ghoul_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_goin__under_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_gunpowder_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_initial_d_go_beat_crazy_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_jumpin_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_mad_scientist_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_mc_mental___his_best_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_mecha_tribe_assault_ssc extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_milf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_multiversus_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_no_villains_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_no_villains_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_philly_b_sides_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_prejudice_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_rawr_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_roses_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_run_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_skill_issues_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_skippa_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_skippa_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_spookeez_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_spookeez_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_sporting_voiid_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_sporting_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_squid_games_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_sudden_death_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_synergy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_the_end_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_thorns_b_sides_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_thunderstorm_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_timeout_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_trouble_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_trouble_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_warm_up_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_charts_why_do_you_hate_me_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_keybinds_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_songlist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_death_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_bold_otf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_otf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_goin__under_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_goin__under_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_damenubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_danger_arrows_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_danger_arrows_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_entity_arrows_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_entity_arrows_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_normal_arrows_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_normal_arrows_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_og_arrows_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_og_arrows_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_shitbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_songselection_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stepmania_arrows_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_stepmania_arrows_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_initial_d_go_beat_crazy_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_mc_mental___his_best_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_mc_mental___his_best_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_mc_mental___his_best_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_mc_mental___his_best_sm_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_mecha_tribe_assault_ssc_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_50_ways_to_say_goodbye_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_7seven_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_accelerant_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_ballistic_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_blazeborn_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_blocked_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_boogie_man_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_boxing_match_voiid_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_burnout_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_bushwhack_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_corn_theft_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_cough_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_crazylittlelove_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_dadbattle_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_danger_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_death_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_detected_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_dilan_noises_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_disruption_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_endless_battle_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_expurgation_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_final_draft_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_finale_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_fixette_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_flippin_out_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_foolhardy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_galaxy_collapse_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_ghoul_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_goin__under_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_gunpowder_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_initial_d_go_beat_crazy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_jumpin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_mad_scientist_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_mc_mental___his_best_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_mecha_tribe_assault_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_milf_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_multiversus_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_no_villains_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_obsolete_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_philly_b_sides_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_prejudice_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_rawr_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_roses_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_run_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_skill_issues_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_skippa_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_spookeez_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_sporting_voiid_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_sporting_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_squid_games_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_sudden_death_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_synergy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_the_end_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_thorns_b_sides_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_thunderstorm_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_timeout_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_trouble_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_warm_up_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_why_do_you_hate_me_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_clap_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_clap_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_missnote1_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sudden_death_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sudden_death_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sudden_death_sm_old extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_timeout_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_timeout_sm extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/fonts/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/fonts/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}

@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_bold_otf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/Funkin-Bold.otf"; name = "Funkin Bold"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_otf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/funkin.otf"; name = "Funkin"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/pixel.otf"; name = "Pixel Arial 11 Bold"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/vcr.ttf"; name = "VCR OSD Mono"; super (); }}


#else

@:keep @:expose('__ASSET__assets_fonts_funkin_bold_otf') @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_bold_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Funkin-Bold.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Funkin Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_funkin_otf') @:noCompletion #if display private #end class __ASSET__assets_fonts_funkin_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/funkin.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Funkin"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/pixel.otf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Pixel Arial 11 Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/vcr.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "VCR OSD Mono"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_funkin_bold_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_funkin_bold_otf extends openfl.text.Font { public function new () { name = "Funkin Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_funkin_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_funkin_otf extends openfl.text.Font { public function new () { name = "Funkin"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pixel_otf extends openfl.text.Font { public function new () { name = "Pixel Arial 11 Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_vcr_ttf extends openfl.text.Font { public function new () { name = "VCR OSD Mono"; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_funkin_bold_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_funkin_bold_otf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/Funkin-Bold.otf"; name = "Funkin Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_funkin_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_funkin_otf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/funkin.otf"; name = "Funkin"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pixel_otf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/pixel.otf"; name = "Pixel Arial 11 Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_vcr_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/vcr.ttf"; name = "VCR OSD Mono"; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
