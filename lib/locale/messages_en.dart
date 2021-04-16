// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(minLength, maxLength) => "(${minLength}-${maxLength} characters)";

  static m1(minLength, maxLength) =>
      "Description must be between ${minLength} and ${maxLength} characters.";

  static m2(minLength, maxLength) =>
      "Name must be between ${minLength} and ${maxLength} characters.";

  static m3(minLength, maxLength) =>
      "Password must be between ${minLength} and ${maxLength} characters.";

  static m4(maxLength) =>
      "A username can\'t be longer than ${maxLength} characters.";

  static m5(maxLength) =>
      "Adjectives can\'t be longer than ${maxLength} characters.";

  static m6(username) =>
      "Are you sure you want to add @${username} as a community administrator?";

  static m7(username) => "Are you sure you want to ban @${username}?";

  static m8(maxLength) =>
      "Description can\'t be longer than ${maxLength} characters.";

  static m9(username) =>
      "Are you sure you want to add @${username} as a community moderator?";

  static m10(maxLength) =>
      "Name can\'t be longer than ${maxLength} characters.";

  static m11(min) => "You must pick at least ${min} categories.";

  static m12(min) => "You must pick at least ${min} category.";

  static m13(max) => "Pick up to ${max} categories";

  static m14(maxLength) =>
      "Rules can\'t be longer than ${maxLength} characters.";

  static m15(takenName) => "Community name \'${takenName}\' is taken";

  static m16(maxLength) =>
      "Title can\'t be longer than ${maxLength} characters.";

  static m17(categoryName) => "Trending in ${categoryName}";

  static m18(hashtag) => "You\'ll be the first to use #${hashtag}";

  static m19(platform) => "Running on ${platform}";

  static m20(currentUserLanguage) => "Language (${currentUserLanguage})";

  static m67(limit) => "Text is too long (limit: ${limit} characters)";

  static m21(limit) => "File too large (limit: ${limit} MB)";

  static m22(resourceCount, resourceName) =>
      "See all ${resourceCount} ${resourceName}";

  static m23(postCommentText) =>
      "[name] [username] also commented: ${postCommentText}";

  static m24(postCommentText) =>
      "[name] [username] commented on your post: ${postCommentText}";

  static m25(postCommentText) =>
      "[name] [username] also replied: ${postCommentText}";

  static m26(postCommentText) =>
      "[name] [username] replied: ${postCommentText}";

  static m27(communityName) => "There was a new post in c/${communityName}.";

  static m28(postCommentText) =>
      "[name] [username] mentioned you on a comment: ${postCommentText}";

  static m29(communityName) =>
      "[name] [username] has invited you to join community c/${communityName}.";

  static m30(maxLength) =>
      "A comment can\'t be longer than ${maxLength} characters.";

  static m31(commentsCount) => "View all ${commentsCount} comments";

  static m32(maxHashtags, maxCharacters) =>
      "Please add a maximum of ${maxHashtags} hashtags and keep them under ${maxCharacters} characters.";

  static m33(circlesSearchQuery) =>
      "No circles found matching \'${circlesSearchQuery}\'.";

  static m34(name) => "${name} has not shared anything yet.";

  static m35(postCreatorUsername) => "@${postCreatorUsername}\'s circles";

  static m36(description) =>
      "Failed to preview link with website error: ${description}";

  static m68(link) => "Invalid link: ${link}";

  static m37(maxLength) =>
      "Circle name must be no longer than ${maxLength} characters.";

  static m38(prettyUsersCount) => "${prettyUsersCount} people";

  static m39(username) => "Are you sure you want to block @${username}?";

  static m40(userName) => "Confirm connection with ${userName}";

  static m41(userName) => "Connect with ${userName}";

  static m42(userName) => "Disconnect from ${userName}";

  static m43(limit) => "Image too large (limit: ${limit} MB)";

  static m44(username) => "Username @${username} is taken";

  static m45(searchQuery) => "No emoji found matching \'${searchQuery}\'.";

  static m46(searchQuery) => "No list found for \'${searchQuery}\'";

  static m47(prettyUsersCount) => "${prettyUsersCount} accounts";

  static m48(prettyUsersCount) => "${prettyUsersCount} Accounts";

  static m49(groupName) => "See all ${groupName}";

  static m50(iosLink, testFlightLink, androidLink, inviteLink) =>
      "Hey, I\'d like to invite you to Okuna.\n\nFor Apple, first, download the TestFlight app on iTunes (${testFlightLink}) and then download the Okuna app (${iosLink})\n\nFor Android, download it from the Play store (${androidLink}).\n\nSecond, paste this personalised invite link in the \'Sign up\' form in the Okuna App: ${inviteLink}";

  static m51(username) => "Joined with username @${username}";

  static m52(email) => "Pending, invite email sent to ${email}";

  static m53(maxLength) =>
      "List name must be no longer than ${maxLength} characters.";

  static m54(maxLength) => "Bio can\'t be longer than ${maxLength} characters.";

  static m55(maxLength) =>
      "Location can\'t be longer than ${maxLength} characters.";

  static m56(age) => "On Okuna since ${age}";

  static m57(takenConnectionsCircleName) =>
      "Circle name \'${takenConnectionsCircleName}\' is taken";

  static m58(listName) => "List name \'${listName}\' is taken";

  static m59(searchQuery) => "No match for \'${searchQuery}\'.";

  static m60(resourcePluralName) => "No ${resourcePluralName} found.";

  static m61(resourcePluralName) => "Search ${resourcePluralName} ...";

  static m62(searchQuery) => "No communities found for \'${searchQuery}\'.";

  static m63(searchQuery) => "No hashtags found for \'${searchQuery}\'.";

  static m64(searchQuery) => "No results for \'${searchQuery}\'.";

  static m65(searchQuery) => "No users found for \'${searchQuery}\'.";

  static m66(searchQuery) => "Searching for \'${searchQuery}\'";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "application_settings__comment_sort_newest_first":
            MessageLookupByLibrary.simpleMessage("Newest first"),
        "application_settings__comment_sort_oldest_first":
            MessageLookupByLibrary.simpleMessage("Oldest first"),
        "application_settings__hashtags":
            MessageLookupByLibrary.simpleMessage("Hashtags"),
        "application_settings__hashtags_display":
            MessageLookupByLibrary.simpleMessage("Display"),
        "application_settings__hashtags_display_disco":
            MessageLookupByLibrary.simpleMessage("🕺 Disco"),
        "application_settings__hashtags_display_traditional":
            MessageLookupByLibrary.simpleMessage("Traditional"),
        "application_settings__link_previews":
            MessageLookupByLibrary.simpleMessage("Link previews"),
        "application_settings__link_previews_autoplay_always":
            MessageLookupByLibrary.simpleMessage("Always"),
        "application_settings__link_previews_autoplay_never":
            MessageLookupByLibrary.simpleMessage("Never"),
        "application_settings__link_previews_autoplay_wifi_only":
            MessageLookupByLibrary.simpleMessage("Wifi only"),
        "application_settings__link_previews_show":
            MessageLookupByLibrary.simpleMessage("Show"),
        "application_settings__tap_to_change":
            MessageLookupByLibrary.simpleMessage("(Tap to change)"),
        "application_settings__videos":
            MessageLookupByLibrary.simpleMessage("Videos"),
        "application_settings__videos_autoplay":
            MessageLookupByLibrary.simpleMessage("Autoplay"),
        "application_settings__videos_autoplay_always":
            MessageLookupByLibrary.simpleMessage("Always"),
        "application_settings__videos_autoplay_never":
            MessageLookupByLibrary.simpleMessage("Never"),
        "application_settings__videos_autoplay_wifi_only":
            MessageLookupByLibrary.simpleMessage("Wifi only"),
        "application_settings__videos_sound":
            MessageLookupByLibrary.simpleMessage("Sound"),
        "application_settings__videos_sound_disabled":
            MessageLookupByLibrary.simpleMessage("Disabled"),
        "application_settings__videos_sound_enabled":
            MessageLookupByLibrary.simpleMessage("Enabled"),
        "auth__change_password_current_pwd":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "auth__change_password_current_pwd_hint":
            MessageLookupByLibrary.simpleMessage("Enter your current password"),
        "auth__change_password_current_pwd_incorrect":
            MessageLookupByLibrary.simpleMessage(
                "Entered password was incorrect"),
        "auth__change_password_new_pwd":
            MessageLookupByLibrary.simpleMessage("New password"),
        "auth__change_password_new_pwd_error":
            MessageLookupByLibrary.simpleMessage(
                "Please ensure password is between 10 and 100 characters long"),
        "auth__change_password_new_pwd_hint":
            MessageLookupByLibrary.simpleMessage("Enter your new password"),
        "auth__change_password_save_success":
            MessageLookupByLibrary.simpleMessage(
                "All good! Your password has been updated"),
        "auth__change_password_save_text":
            MessageLookupByLibrary.simpleMessage("Save"),
        "auth__change_password_title":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "auth__create_acc__almost_there":
            MessageLookupByLibrary.simpleMessage("Almost there..."),
        "auth__create_acc__are_you_legal_age":
            MessageLookupByLibrary.simpleMessage(
                "Are you older than 16 years?"),
        "auth__create_acc__avatar_choose_camera":
            MessageLookupByLibrary.simpleMessage("Take a photo"),
        "auth__create_acc__avatar_choose_gallery":
            MessageLookupByLibrary.simpleMessage("Use an existing photo"),
        "auth__create_acc__avatar_remove_photo":
            MessageLookupByLibrary.simpleMessage("Remove photo"),
        "auth__create_acc__avatar_tap_to_change":
            MessageLookupByLibrary.simpleMessage("Tap to change"),
        "auth__create_acc__can_change_username":
            MessageLookupByLibrary.simpleMessage(
                "If you wish, you can change it anytime via your profile page."),
        "auth__create_acc__congratulations":
            MessageLookupByLibrary.simpleMessage("Congratulations!"),
        "auth__create_acc__create_account":
            MessageLookupByLibrary.simpleMessage("Create account"),
        "auth__create_acc__done":
            MessageLookupByLibrary.simpleMessage("Create account"),
        "auth__create_acc__done_continue":
            MessageLookupByLibrary.simpleMessage("Login"),
        "auth__create_acc__done_created": MessageLookupByLibrary.simpleMessage(
            "Your account has been created."),
        "auth__create_acc__done_description":
            MessageLookupByLibrary.simpleMessage(
                "Your account has been created."),
        "auth__create_acc__done_subtext": MessageLookupByLibrary.simpleMessage(
            "You can change this in your profile settings."),
        "auth__create_acc__done_title":
            MessageLookupByLibrary.simpleMessage("Hooray!"),
        "auth__create_acc__email_empty_error":
            MessageLookupByLibrary.simpleMessage(
                "😱 Your email can\'t be empty"),
        "auth__create_acc__email_invalid_error":
            MessageLookupByLibrary.simpleMessage(
                "😅 Please provide a valid email address."),
        "auth__create_acc__email_placeholder":
            MessageLookupByLibrary.simpleMessage("john_travolta@mail.com"),
        "auth__create_acc__email_server_error":
            MessageLookupByLibrary.simpleMessage(
                "😭 We\'re experiencing issues with our servers, please try again in a couple of minutes."),
        "auth__create_acc__email_taken_error":
            MessageLookupByLibrary.simpleMessage(
                "🤔 An account already exists for that email."),
        "auth__create_acc__invalid_token":
            MessageLookupByLibrary.simpleMessage("Invalid token"),
        "auth__create_acc__lets_get_started":
            MessageLookupByLibrary.simpleMessage("Let\'s get started"),
        "auth__create_acc__link_empty_error":
            MessageLookupByLibrary.simpleMessage("Link cannot be empty."),
        "auth__create_acc__link_invalid_error":
            MessageLookupByLibrary.simpleMessage("This link is invalid."),
        "auth__create_acc__name_characters_error":
            MessageLookupByLibrary.simpleMessage(
                "😅 A name can only contain alphanumeric characters (for now)."),
        "auth__create_acc__name_empty_error":
            MessageLookupByLibrary.simpleMessage(
                "😱 Your name can\'t be empty."),
        "auth__create_acc__name_length_error": MessageLookupByLibrary.simpleMessage(
            "😱 Your name can\'t be longer than 50 characters. (If it is, we\'re very sorry.)"),
        "auth__create_acc__name_placeholder":
            MessageLookupByLibrary.simpleMessage("James Bond"),
        "auth__create_acc__next": MessageLookupByLibrary.simpleMessage("Next"),
        "auth__create_acc__one_last_thing":
            MessageLookupByLibrary.simpleMessage("One last thing..."),
        "auth__create_acc__password_empty_error":
            MessageLookupByLibrary.simpleMessage(
                "😱 Your password can\'t be empty"),
        "auth__create_acc__password_length_error":
            MessageLookupByLibrary.simpleMessage(
                "😅 A password must be between 8 and 64 characters."),
        "auth__create_acc__paste_link": MessageLookupByLibrary.simpleMessage(
            "Paste your registration link below"),
        "auth__create_acc__paste_link_help_text":
            MessageLookupByLibrary.simpleMessage(
                "Use the link from the Join Openbook button in your invitation email."),
        "auth__create_acc__paste_password_reset_link":
            MessageLookupByLibrary.simpleMessage(
                "Paste your password reset link below"),
        "auth__create_acc__previous":
            MessageLookupByLibrary.simpleMessage("Back"),
        "auth__create_acc__register":
            MessageLookupByLibrary.simpleMessage("Register"),
        "auth__create_acc__request_invite":
            MessageLookupByLibrary.simpleMessage(
                "No invite? Request one here."),
        "auth__create_acc__submit_error_desc_server":
            MessageLookupByLibrary.simpleMessage(
                "😭 We\'re experiencing issues with our servers, please try again in a couple of minutes."),
        "auth__create_acc__submit_error_desc_validation":
            MessageLookupByLibrary.simpleMessage(
                "😅 It looks like some of the information was not right, please check and try again."),
        "auth__create_acc__submit_error_title":
            MessageLookupByLibrary.simpleMessage("Oh no..."),
        "auth__create_acc__submit_loading_desc":
            MessageLookupByLibrary.simpleMessage(
                "We\'re creating your account."),
        "auth__create_acc__submit_loading_title":
            MessageLookupByLibrary.simpleMessage("Hang in there!"),
        "auth__create_acc__subscribe":
            MessageLookupByLibrary.simpleMessage("Request"),
        "auth__create_acc__subscribe_to_waitlist_text":
            MessageLookupByLibrary.simpleMessage("Request an invite!"),
        "auth__create_acc__suggested_communities":
            MessageLookupByLibrary.simpleMessage(
                "🥳 Get started by joining the following organizations."),
        "auth__create_acc__username_characters_error":
            MessageLookupByLibrary.simpleMessage(
                "😅 A username can only contain alphanumeric characters and underscores."),
        "auth__create_acc__username_empty_error":
            MessageLookupByLibrary.simpleMessage(
                "😱 The username can\'t be empty."),
        "auth__create_acc__username_length_error":
            MessageLookupByLibrary.simpleMessage(
                "😅 A username can\'t be longer than 30 characters."),
        "auth__create_acc__username_placeholder":
            MessageLookupByLibrary.simpleMessage("pablopicasso"),
        "auth__create_acc__username_server_error":
            MessageLookupByLibrary.simpleMessage(
                "😭 We\'re experiencing issues with our servers, please try again in a couple of minutes."),
        "auth__create_acc__username_taken_error":
            MessageLookupByLibrary.simpleMessage(
                "😩 The username @%s is taken."),
        "auth__create_acc__validating_token":
            MessageLookupByLibrary.simpleMessage("Validating token..."),
        "auth__create_acc__welcome_to_beta":
            MessageLookupByLibrary.simpleMessage("Welcome to the Beta!"),
        "auth__create_acc__what_avatar":
            MessageLookupByLibrary.simpleMessage("Choose a profile picture"),
        "auth__create_acc__what_email":
            MessageLookupByLibrary.simpleMessage("What\'s your email?"),
        "auth__create_acc__what_name":
            MessageLookupByLibrary.simpleMessage("What\'s your name?"),
        "auth__create_acc__what_password":
            MessageLookupByLibrary.simpleMessage("Choose a password"),
        "auth__create_acc__what_password_subtext":
            MessageLookupByLibrary.simpleMessage("(min 10 chars.)"),
        "auth__create_acc__what_username":
            MessageLookupByLibrary.simpleMessage("Choose a username"),
        "auth__create_acc__your_subscribed":
            MessageLookupByLibrary.simpleMessage(
                "You\'re {0} on the waitlist."),
        "auth__create_acc__your_username_is":
            MessageLookupByLibrary.simpleMessage("Your user name is "),
        "auth__create_acc_password_hint_text": m0,
        "auth__create_account": MessageLookupByLibrary.simpleMessage("Sign up"),
        "auth__description_empty_error": MessageLookupByLibrary.simpleMessage(
            "Description cannot be empty."),
        "auth__description_range_error": m1,
        "auth__email_empty_error":
            MessageLookupByLibrary.simpleMessage("Email cannot be empty."),
        "auth__email_invalid_error": MessageLookupByLibrary.simpleMessage(
            "Please provide a valid email."),
        "auth__headline":
            MessageLookupByLibrary.simpleMessage("Better social."),
        "auth__login": MessageLookupByLibrary.simpleMessage("Log in"),
        "auth__login__connection_error": MessageLookupByLibrary.simpleMessage(
            "We can\'t reach our servers. Are you connected to the internet?"),
        "auth__login__credentials_mismatch_error":
            MessageLookupByLibrary.simpleMessage(
                "The provided credentials do not match."),
        "auth__login__email_label":
            MessageLookupByLibrary.simpleMessage("Email"),
        "auth__login__forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot password"),
        "auth__login__forgot_password_subtitle":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "auth__login__login": MessageLookupByLibrary.simpleMessage("Continue"),
        "auth__login__password_empty_error":
            MessageLookupByLibrary.simpleMessage("Password is required."),
        "auth__login__password_label":
            MessageLookupByLibrary.simpleMessage("Password"),
        "auth__login__password_length_error":
            MessageLookupByLibrary.simpleMessage(
                "Password must be between 8 and 64 characters."),
        "auth__login__previous":
            MessageLookupByLibrary.simpleMessage("Previous"),
        "auth__login__server_error": MessageLookupByLibrary.simpleMessage(
            "Uh oh.. We\'re experiencing server issues. Please try again in a few minutes."),
        "auth__login__subtitle": MessageLookupByLibrary.simpleMessage(
            "Enter your credentials to continue."),
        "auth__login__title":
            MessageLookupByLibrary.simpleMessage("Welcome back!"),
        "auth__login__username_characters_error":
            MessageLookupByLibrary.simpleMessage(
                "Username can only contain alphanumeric characters and underscores."),
        "auth__login__username_empty_error":
            MessageLookupByLibrary.simpleMessage("Username is required."),
        "auth__login__username_label":
            MessageLookupByLibrary.simpleMessage("Username"),
        "auth__login__username_length_error":
            MessageLookupByLibrary.simpleMessage(
                "Username can\'t be longer than 30 characters."),
        "auth__name_empty_error":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "auth__name_range_error": m2,
        "auth__password_empty_error":
            MessageLookupByLibrary.simpleMessage("Password cannot be empty."),
        "auth__password_range_error": m3,
        "auth__reset_password_success_info":
            MessageLookupByLibrary.simpleMessage(
                "Your password has been updated successfully"),
        "auth__reset_password_success_title":
            MessageLookupByLibrary.simpleMessage("All set!"),
        "auth__username_characters_error": MessageLookupByLibrary.simpleMessage(
            "A username can only contain alphanumeric characters and underscores."),
        "auth__username_empty_error":
            MessageLookupByLibrary.simpleMessage("Username cannot be empty."),
        "auth__username_maxlength_error": m4,
        "bottom_sheets__confirm_action_are_you_sure":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "bottom_sheets__confirm_action_no":
            MessageLookupByLibrary.simpleMessage("No"),
        "bottom_sheets__confirm_action_yes":
            MessageLookupByLibrary.simpleMessage("Yes"),
        "community__about": MessageLookupByLibrary.simpleMessage("About"),
        "community__actions_disable_new_post_notifications_success":
            MessageLookupByLibrary.simpleMessage(
                "New post notifications enabled"),
        "community__actions_disable_new_post_notifications_title":
            MessageLookupByLibrary.simpleMessage(
                "Disable new post notifications"),
        "community__actions_enable_new_post_notifications_success":
            MessageLookupByLibrary.simpleMessage(
                "New post notifications enabled"),
        "community__actions_enable_new_post_notifications_title":
            MessageLookupByLibrary.simpleMessage(
                "Enable new post notifications"),
        "community__actions_invite_people_title":
            MessageLookupByLibrary.simpleMessage("Invite people to community"),
        "community__actions_manage_text":
            MessageLookupByLibrary.simpleMessage("Manage"),
        "community__add_administrators_title":
            MessageLookupByLibrary.simpleMessage("Add administrator"),
        "community__add_moderator_title":
            MessageLookupByLibrary.simpleMessage("Add moderator"),
        "community__adjectives_range_error": m5,
        "community__admin_add_confirmation": m6,
        "community__admin_desc": MessageLookupByLibrary.simpleMessage(
            "This will allow the member to edit the community details, administrators, moderators and banned users."),
        "community__administrated_communities":
            MessageLookupByLibrary.simpleMessage("administrated organizations"),
        "community__administrated_community":
            MessageLookupByLibrary.simpleMessage("administrated community"),
        "community__administrated_title":
            MessageLookupByLibrary.simpleMessage("Administrated"),
        "community__administrator_plural":
            MessageLookupByLibrary.simpleMessage("administrators"),
        "community__administrator_text":
            MessageLookupByLibrary.simpleMessage("administrator"),
        "community__administrator_you":
            MessageLookupByLibrary.simpleMessage("You"),
        "community__administrators_title":
            MessageLookupByLibrary.simpleMessage("Administrators"),
        "community__ban_confirmation": m7,
        "community__ban_desc": MessageLookupByLibrary.simpleMessage(
            "This will remove the user from the community and disallow them from joining again."),
        "community__ban_user_title":
            MessageLookupByLibrary.simpleMessage("Ban user"),
        "community__banned_user_text":
            MessageLookupByLibrary.simpleMessage("banned user"),
        "community__banned_users_text":
            MessageLookupByLibrary.simpleMessage("banned users"),
        "community__banned_users_title":
            MessageLookupByLibrary.simpleMessage("Banned users"),
        "community__button_rules":
            MessageLookupByLibrary.simpleMessage("Rules"),
        "community__button_staff":
            MessageLookupByLibrary.simpleMessage("Staff"),
        "community__categories":
            MessageLookupByLibrary.simpleMessage("categories."),
        "community__category":
            MessageLookupByLibrary.simpleMessage("category."),
        "community__communities":
            MessageLookupByLibrary.simpleMessage("organizations"),
        "community__communities_all_text":
            MessageLookupByLibrary.simpleMessage("All"),
        "community__communities_no_category_found":
            MessageLookupByLibrary.simpleMessage(
                "No categories found. Please try again in a few minutes."),
        "community__communities_refresh_text":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "community__communities_title":
            MessageLookupByLibrary.simpleMessage("Organizations"),
        "community__community":
            MessageLookupByLibrary.simpleMessage("community"),
        "community__community_members":
            MessageLookupByLibrary.simpleMessage("Community members"),
        "community__community_staff":
            MessageLookupByLibrary.simpleMessage("Community staff"),
        "community__community_type_private_community_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "Note: Private organizations cannot be later changed to Public"),
        "community__confirmation_title":
            MessageLookupByLibrary.simpleMessage("Confirmation"),
        "community__delete_confirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete the community?"),
        "community__delete_desc": MessageLookupByLibrary.simpleMessage(
            "You won\'t see it\'s posts in your timeline nor will be able to post to it anymore."),
        "community__description_range_error": m8,
        "community__details_favorite":
            MessageLookupByLibrary.simpleMessage("In favorites"),
        "community__exclude_joined_communities":
            MessageLookupByLibrary.simpleMessage(
                "Exclude joined organizations"),
        "community__exclude_joined_communities_desc":
            MessageLookupByLibrary.simpleMessage(
                "Don\'t show posts from communities I\'m a member of"),
        "community__excluded_communities":
            MessageLookupByLibrary.simpleMessage("hidden organizations"),
        "community__excluded_community":
            MessageLookupByLibrary.simpleMessage("hidden community"),
        "community__favorite_action":
            MessageLookupByLibrary.simpleMessage("Favorite community"),
        "community__favorite_communities":
            MessageLookupByLibrary.simpleMessage("favorite organizations"),
        "community__favorite_community":
            MessageLookupByLibrary.simpleMessage("favorite community"),
        "community__favorites_title":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "community__invite_to_community_resource_plural":
            MessageLookupByLibrary.simpleMessage("connections and followers"),
        "community__invite_to_community_resource_singular":
            MessageLookupByLibrary.simpleMessage("connection or follower"),
        "community__invite_to_community_title":
            MessageLookupByLibrary.simpleMessage("Invite to community"),
        "community__invited_by_member": MessageLookupByLibrary.simpleMessage(
            "You must be invited by a member."),
        "community__invited_by_moderator": MessageLookupByLibrary.simpleMessage(
            "You must be invited by a moderator."),
        "community__is_private":
            MessageLookupByLibrary.simpleMessage("This community is private."),
        "community__join_communities_desc":
            MessageLookupByLibrary.simpleMessage(
                "Join organizations to see this tab come to life!"),
        "community__join_community":
            MessageLookupByLibrary.simpleMessage("Join"),
        "community__joined_communities":
            MessageLookupByLibrary.simpleMessage("joined organizations"),
        "community__joined_community":
            MessageLookupByLibrary.simpleMessage("joined community"),
        "community__joined_title":
            MessageLookupByLibrary.simpleMessage("Joined"),
        "community__leave_community":
            MessageLookupByLibrary.simpleMessage("Leave"),
        "community__leave_confirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to leave the community?"),
        "community__leave_desc": MessageLookupByLibrary.simpleMessage(
            "You won\'t see its posts in your timeline nor will be able to post to it anymore."),
        "community__manage_add_favourite": MessageLookupByLibrary.simpleMessage(
            "Add the community to your favorites"),
        "community__manage_admins_desc": MessageLookupByLibrary.simpleMessage(
            "See, add and remove administrators."),
        "community__manage_admins_title":
            MessageLookupByLibrary.simpleMessage("Administrators"),
        "community__manage_banned_desc": MessageLookupByLibrary.simpleMessage(
            "See, add and remove banned users."),
        "community__manage_banned_title":
            MessageLookupByLibrary.simpleMessage("Banned users"),
        "community__manage_closed_posts_desc":
            MessageLookupByLibrary.simpleMessage("See and manage closed posts"),
        "community__manage_closed_posts_title":
            MessageLookupByLibrary.simpleMessage("Closed posts"),
        "community__manage_delete_desc": MessageLookupByLibrary.simpleMessage(
            "Delete the community, forever."),
        "community__manage_delete_title":
            MessageLookupByLibrary.simpleMessage("Delete community"),
        "community__manage_details_desc": MessageLookupByLibrary.simpleMessage(
            "Change the title, name, avatar, cover photo and more."),
        "community__manage_details_title":
            MessageLookupByLibrary.simpleMessage("Details"),
        "community__manage_disable_new_post_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Disable new post notifications"),
        "community__manage_enable_new_post_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Enable new post notifications"),
        "community__manage_invite_desc": MessageLookupByLibrary.simpleMessage(
            "Invite your connections and followers to join the community."),
        "community__manage_invite_title":
            MessageLookupByLibrary.simpleMessage("Invite people"),
        "community__manage_leave_desc":
            MessageLookupByLibrary.simpleMessage("Leave the community."),
        "community__manage_leave_title":
            MessageLookupByLibrary.simpleMessage("Leave community"),
        "community__manage_mod_reports_desc":
            MessageLookupByLibrary.simpleMessage(
                "Review the community moderation reports."),
        "community__manage_mod_reports_title":
            MessageLookupByLibrary.simpleMessage("Moderation reports"),
        "community__manage_mods_desc": MessageLookupByLibrary.simpleMessage(
            "See, add and remove moderators."),
        "community__manage_mods_title":
            MessageLookupByLibrary.simpleMessage("Moderators"),
        "community__manage_remove_favourite":
            MessageLookupByLibrary.simpleMessage(
                "Remove the community from your favorites"),
        "community__manage_title":
            MessageLookupByLibrary.simpleMessage("Manage community"),
        "community__member": MessageLookupByLibrary.simpleMessage("member"),
        "community__member_capitalized":
            MessageLookupByLibrary.simpleMessage("Member"),
        "community__member_plural":
            MessageLookupByLibrary.simpleMessage("members"),
        "community__members_capitalized":
            MessageLookupByLibrary.simpleMessage("Members"),
        "community__moderated_communities":
            MessageLookupByLibrary.simpleMessage("moderated organizations"),
        "community__moderated_community":
            MessageLookupByLibrary.simpleMessage("moderated community"),
        "community__moderated_title":
            MessageLookupByLibrary.simpleMessage("Moderated"),
        "community__moderator_add_confirmation": m9,
        "community__moderator_desc": MessageLookupByLibrary.simpleMessage(
            "This will allow the member to edit the community details, moderators and banned users."),
        "community__moderator_resource_name":
            MessageLookupByLibrary.simpleMessage("moderator"),
        "community__moderators_resource_name":
            MessageLookupByLibrary.simpleMessage("moderators"),
        "community__moderators_title":
            MessageLookupByLibrary.simpleMessage("Moderators"),
        "community__moderators_you":
            MessageLookupByLibrary.simpleMessage("You"),
        "community__name_characters_error": MessageLookupByLibrary.simpleMessage(
            "Name can only contain alphanumeric characters and underscores."),
        "community__name_empty_error":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "community__name_range_error": m10,
        "community__no": MessageLookupByLibrary.simpleMessage("No"),
        "community__pick_atleast_min_categories": m11,
        "community__pick_atleast_min_category": m12,
        "community__pick_upto_max": m13,
        "community__post_plural": MessageLookupByLibrary.simpleMessage("posts"),
        "community__post_singular":
            MessageLookupByLibrary.simpleMessage("post"),
        "community__posts": MessageLookupByLibrary.simpleMessage("Posts"),
        "community__refresh_text":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "community__refreshing":
            MessageLookupByLibrary.simpleMessage("Refreshing community"),
        "community__retry_loading_posts":
            MessageLookupByLibrary.simpleMessage("Tap to retry"),
        "community__rules_empty_error":
            MessageLookupByLibrary.simpleMessage("Rules cannot be empty."),
        "community__rules_range_error": m14,
        "community__rules_text": MessageLookupByLibrary.simpleMessage("Rules"),
        "community__rules_title":
            MessageLookupByLibrary.simpleMessage("Community rules"),
        "community__save_community_create_community":
            MessageLookupByLibrary.simpleMessage("Create community"),
        "community__save_community_create_text":
            MessageLookupByLibrary.simpleMessage("Create"),
        "community__save_community_edit_community":
            MessageLookupByLibrary.simpleMessage("Edit community"),
        "community__save_community_label_title":
            MessageLookupByLibrary.simpleMessage("Title"),
        "community__save_community_label_title_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "e.g. Travel, Photography, Gaming."),
        "community__save_community_name_category":
            MessageLookupByLibrary.simpleMessage("Category"),
        "community__save_community_name_label_color":
            MessageLookupByLibrary.simpleMessage("Color"),
        "community__save_community_name_label_color_hint_text":
            MessageLookupByLibrary.simpleMessage("(Tap to change)"),
        "community__save_community_name_label_desc_optional":
            MessageLookupByLibrary.simpleMessage("Description · Optional"),
        "community__save_community_name_label_desc_optional_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "What is your community about?"),
        "community__save_community_name_label_member_adjective":
            MessageLookupByLibrary.simpleMessage("Member adjective · Optional"),
        "community__save_community_name_label_member_adjective_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "e.g. traveler, photographer, gamer."),
        "community__save_community_name_label_members_adjective":
            MessageLookupByLibrary.simpleMessage(
                "Members adjective · Optional"),
        "community__save_community_name_label_members_adjective_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "e.g. travelers, photographers, gamers."),
        "community__save_community_name_label_rules_optional":
            MessageLookupByLibrary.simpleMessage("Rules · Optional"),
        "community__save_community_name_label_rules_optional_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "Is there something you would like your users to know?"),
        "community__save_community_name_label_type":
            MessageLookupByLibrary.simpleMessage("Type"),
        "community__save_community_name_label_type_hint_text":
            MessageLookupByLibrary.simpleMessage("(Tap to change)"),
        "community__save_community_name_member_invites":
            MessageLookupByLibrary.simpleMessage("Member invites"),
        "community__save_community_name_member_invites_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Members can invite people to the community"),
        "community__save_community_name_taken": m15,
        "community__save_community_name_title":
            MessageLookupByLibrary.simpleMessage("Name"),
        "community__save_community_name_title_hint_text":
            MessageLookupByLibrary.simpleMessage(
                " e.g. travel, photography, gaming."),
        "community__save_community_save_text":
            MessageLookupByLibrary.simpleMessage("Save"),
        "community__tile_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "community__title_empty_error":
            MessageLookupByLibrary.simpleMessage("Title cannot be empty."),
        "community__title_range_error": m16,
        "community__top_posts_excluded_communities":
            MessageLookupByLibrary.simpleMessage("Hidden organizations"),
        "community__top_posts_excluded_communities_desc":
            MessageLookupByLibrary.simpleMessage(
                "Manage organizations hidden from the explore timeline"),
        "community__top_posts_settings":
            MessageLookupByLibrary.simpleMessage("Explore settings"),
        "community__trending_in_all":
            MessageLookupByLibrary.simpleMessage("Trending in all categories"),
        "community__trending_in_category": m17,
        "community__trending_none_found": MessageLookupByLibrary.simpleMessage(
            "No trending organizations found. Try again in a few minutes."),
        "community__trending_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "community__type_private":
            MessageLookupByLibrary.simpleMessage("Private"),
        "community__type_public":
            MessageLookupByLibrary.simpleMessage("Public"),
        "community__unfavorite_action":
            MessageLookupByLibrary.simpleMessage("Unfavorite community"),
        "community__user_you_text": MessageLookupByLibrary.simpleMessage("You"),
        "community__yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "contextual_account_search_box__no_results":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "contextual_account_search_box__suggestions":
            MessageLookupByLibrary.simpleMessage("Suggestions"),
        "contextual_community_search_box__no_results":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "contextual_community_search_box__suggestions":
            MessageLookupByLibrary.simpleMessage("Suggestions"),
        "contextual_hashtag_search_box__be_the_first": m18,
        "drawer__about": MessageLookupByLibrary.simpleMessage("About"),
        "drawer__about_platform": m19,
        "drawer__account_settings":
            MessageLookupByLibrary.simpleMessage("Account Settings"),
        "drawer__account_settings_blocked_users":
            MessageLookupByLibrary.simpleMessage("Blocked users"),
        "drawer__account_settings_change_email":
            MessageLookupByLibrary.simpleMessage("Change Email"),
        "drawer__account_settings_change_password":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "drawer__account_settings_delete_account":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "drawer__account_settings_language": m20,
        "drawer__account_settings_language_text":
            MessageLookupByLibrary.simpleMessage("Language"),
        "drawer__account_settings_notifications":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "drawer__app_account_text":
            MessageLookupByLibrary.simpleMessage("App & Account"),
        "drawer__application_settings":
            MessageLookupByLibrary.simpleMessage("Application Settings"),
        "drawer__connections":
            MessageLookupByLibrary.simpleMessage("My connections"),
        "drawer__customize": MessageLookupByLibrary.simpleMessage("Customize"),
        "drawer__developer_settings":
            MessageLookupByLibrary.simpleMessage("Developer Settings"),
        "drawer__global_moderation":
            MessageLookupByLibrary.simpleMessage("Global moderation"),
        "drawer__help":
            MessageLookupByLibrary.simpleMessage("Support & Feedback"),
        "drawer__lists": MessageLookupByLibrary.simpleMessage("My lists"),
        "drawer__logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "drawer__main_title": MessageLookupByLibrary.simpleMessage("My Okuna"),
        "drawer__menu_title": MessageLookupByLibrary.simpleMessage("Menu"),
        "drawer__my_circles":
            MessageLookupByLibrary.simpleMessage("My circles"),
        "drawer__my_followers":
            MessageLookupByLibrary.simpleMessage("My followers"),
        "drawer__my_following":
            MessageLookupByLibrary.simpleMessage("My following"),
        "drawer__my_invites":
            MessageLookupByLibrary.simpleMessage("My invites"),
        "drawer__my_lists": MessageLookupByLibrary.simpleMessage("My lists"),
        "drawer__my_mod_penalties":
            MessageLookupByLibrary.simpleMessage("My moderation penalties"),
        "drawer__my_pending_mod_tasks":
            MessageLookupByLibrary.simpleMessage("My pending moderation tasks"),
        "drawer__profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "drawer__settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "drawer__themes": MessageLookupByLibrary.simpleMessage("Themes"),
        "drawer__useful_links_guidelines":
            MessageLookupByLibrary.simpleMessage("Okuna guidelines"),
        "drawer__useful_links_guidelines_bug_tracker":
            MessageLookupByLibrary.simpleMessage("Bug tracker"),
        "drawer__useful_links_guidelines_bug_tracker_desc":
            MessageLookupByLibrary.simpleMessage(
                "Report a bug or upvote existing bugs"),
        "drawer__useful_links_guidelines_desc":
            MessageLookupByLibrary.simpleMessage(
                "The guidelines we\'re all expected to follow for a healthy and friendly co-existence."),
        "drawer__useful_links_guidelines_feature_requests":
            MessageLookupByLibrary.simpleMessage("Feature requests"),
        "drawer__useful_links_guidelines_feature_requests_desc":
            MessageLookupByLibrary.simpleMessage(
                "Request a feature or upvote existing requests"),
        "drawer__useful_links_guidelines_github":
            MessageLookupByLibrary.simpleMessage("Github project board"),
        "drawer__useful_links_guidelines_github_desc":
            MessageLookupByLibrary.simpleMessage(
                "Take a look at what we\'re currently working on"),
        "drawer__useful_links_guidelines_handbook":
            MessageLookupByLibrary.simpleMessage("Okuna user guide"),
        "drawer__useful_links_guidelines_handbook_desc":
            MessageLookupByLibrary.simpleMessage(
                "A book with everything there is to know about using the platform"),
        "drawer__useful_links_guidelines_roadmap":
            MessageLookupByLibrary.simpleMessage("The Okuna roadmap"),
        "drawer__useful_links_guidelines_roadmap_desc":
            MessageLookupByLibrary.simpleMessage(
                "Take a look at what we\'re planning to do in the future"),
        "drawer__useful_links_slack_channel":
            MessageLookupByLibrary.simpleMessage("Community Slack channel"),
        "drawer__useful_links_slack_channel_desc":
            MessageLookupByLibrary.simpleMessage(
                "A place to discuss everything about Okuna"),
        "drawer__useful_links_support":
            MessageLookupByLibrary.simpleMessage("Support Okuna"),
        "drawer__useful_links_support_desc":
            MessageLookupByLibrary.simpleMessage(
                "Find a way you can support us on our journey!"),
        "drawer__useful_links_title":
            MessageLookupByLibrary.simpleMessage("Useful links"),
        "error__no_internet_connection":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "error__receive_share_file_not_found":
            MessageLookupByLibrary.simpleMessage(
                "Shared file could not be found"),
        "error__receive_share_invalid_uri_scheme":
            MessageLookupByLibrary.simpleMessage("Failed to receive share"),
        "error__receive_share_temp_write_denied":
            MessageLookupByLibrary.simpleMessage(
                "Denied permission to copy shared file to temporary location"),
        "error__receive_share_temp_write_failed":
            MessageLookupByLibrary.simpleMessage(
                "Failed to copy shared file to temporary location"),
        "error__receive_share_text_too_long": m67,
        "error__unknown_error":
            MessageLookupByLibrary.simpleMessage("Unknown error"),
        "image_picker__error_too_large": m21,
        "image_picker__from_camera":
            MessageLookupByLibrary.simpleMessage("From camera"),
        "image_picker__from_gallery":
            MessageLookupByLibrary.simpleMessage("From gallery"),
        "media_service__crop_image":
            MessageLookupByLibrary.simpleMessage("Crop image"),
        "moderation__actions_chat_with_team":
            MessageLookupByLibrary.simpleMessage("Chat with the team"),
        "moderation__actions_review":
            MessageLookupByLibrary.simpleMessage("Review"),
        "moderation__category_text":
            MessageLookupByLibrary.simpleMessage("Category"),
        "moderation__community_moderated_objects":
            MessageLookupByLibrary.simpleMessage("Community moderated objects"),
        "moderation__community_review_approve":
            MessageLookupByLibrary.simpleMessage("Approve"),
        "moderation__community_review_item_verified":
            MessageLookupByLibrary.simpleMessage("This item has been verified"),
        "moderation__community_review_object":
            MessageLookupByLibrary.simpleMessage("Object"),
        "moderation__community_review_reject":
            MessageLookupByLibrary.simpleMessage("reject"),
        "moderation__community_review_title":
            MessageLookupByLibrary.simpleMessage("Review moderated object"),
        "moderation__confirm_report_community_reported":
            MessageLookupByLibrary.simpleMessage("Community reported"),
        "moderation__confirm_report_item_reported":
            MessageLookupByLibrary.simpleMessage("Item reported"),
        "moderation__confirm_report_post_comment_reported":
            MessageLookupByLibrary.simpleMessage("Post comment reported"),
        "moderation__confirm_report_post_reported":
            MessageLookupByLibrary.simpleMessage("Post reported"),
        "moderation__confirm_report_provide_details":
            MessageLookupByLibrary.simpleMessage(
                "Can you provide extra details that might be relevant to the report?"),
        "moderation__confirm_report_provide_happen_next":
            MessageLookupByLibrary.simpleMessage(
                "Here\'s what will happen next:"),
        "moderation__confirm_report_provide_happen_next_desc":
            MessageLookupByLibrary.simpleMessage(
                "- Your report will be submitted anonymously. \n- If you are reporting a post or comment, the report will be sent to the Okuna staff and the community moderators if applicable and the post will be hidden from your feed. \n- If you are reporting an account or community, it will be sent to the Okuna staff. \n- We\'ll review it, if approved, content will be deleted and penalties delivered to the people involved ranging from a temporary suspension to deletion of the account depending on the severity of the transgression. \n- If the report is found to be made in an attempt to damage the reputation of another member or community in the platform with no infringement of the stated reason, penalties will be applied to you. \n"),
        "moderation__confirm_report_provide_optional_hint_text":
            MessageLookupByLibrary.simpleMessage("Type here..."),
        "moderation__confirm_report_provide_optional_info":
            MessageLookupByLibrary.simpleMessage("(Optional)"),
        "moderation__confirm_report_submit":
            MessageLookupByLibrary.simpleMessage("I understand, submit."),
        "moderation__confirm_report_title":
            MessageLookupByLibrary.simpleMessage("Submit report"),
        "moderation__confirm_report_user_reported":
            MessageLookupByLibrary.simpleMessage("User reported"),
        "moderation__description_text":
            MessageLookupByLibrary.simpleMessage("Description"),
        "moderation__filters_apply":
            MessageLookupByLibrary.simpleMessage("Apply filters"),
        "moderation__filters_other":
            MessageLookupByLibrary.simpleMessage("Other"),
        "moderation__filters_reset":
            MessageLookupByLibrary.simpleMessage("Reset"),
        "moderation__filters_status":
            MessageLookupByLibrary.simpleMessage("Status"),
        "moderation__filters_title":
            MessageLookupByLibrary.simpleMessage("Moderation Filters"),
        "moderation__filters_type":
            MessageLookupByLibrary.simpleMessage("Type"),
        "moderation__filters_verified":
            MessageLookupByLibrary.simpleMessage("Verified"),
        "moderation__global_review_object_text":
            MessageLookupByLibrary.simpleMessage("Object"),
        "moderation__global_review_title":
            MessageLookupByLibrary.simpleMessage("Review moderated object"),
        "moderation__global_review_unverify_text":
            MessageLookupByLibrary.simpleMessage("Unverify"),
        "moderation__global_review_verify_text":
            MessageLookupByLibrary.simpleMessage("Verify"),
        "moderation__globally_moderated_objects":
            MessageLookupByLibrary.simpleMessage("Globally moderated objects"),
        "moderation__moderated_object_false_text":
            MessageLookupByLibrary.simpleMessage("False"),
        "moderation__moderated_object_reports_count":
            MessageLookupByLibrary.simpleMessage("Reports count"),
        "moderation__moderated_object_status":
            MessageLookupByLibrary.simpleMessage("Status"),
        "moderation__moderated_object_title":
            MessageLookupByLibrary.simpleMessage("Object"),
        "moderation__moderated_object_true_text":
            MessageLookupByLibrary.simpleMessage("True"),
        "moderation__moderated_object_verified":
            MessageLookupByLibrary.simpleMessage("Verified"),
        "moderation__moderated_object_verified_by_staff":
            MessageLookupByLibrary.simpleMessage("Verified by Okuna staff"),
        "moderation__my_moderation_penalties_resouce_singular":
            MessageLookupByLibrary.simpleMessage("moderation penalty"),
        "moderation__my_moderation_penalties_resource_plural":
            MessageLookupByLibrary.simpleMessage("moderation penalties"),
        "moderation__my_moderation_penalties_title":
            MessageLookupByLibrary.simpleMessage("Moderation penalties"),
        "moderation__my_moderation_tasks_title":
            MessageLookupByLibrary.simpleMessage("Pending moderation tasks"),
        "moderation__no_description_text":
            MessageLookupByLibrary.simpleMessage("No description"),
        "moderation__object_status_title":
            MessageLookupByLibrary.simpleMessage("Status"),
        "moderation__pending_moderation_tasks_plural":
            MessageLookupByLibrary.simpleMessage("pending moderation tasks"),
        "moderation__pending_moderation_tasks_singular":
            MessageLookupByLibrary.simpleMessage("pending moderation task"),
        "moderation__report_account_text":
            MessageLookupByLibrary.simpleMessage("Report account"),
        "moderation__report_comment_text":
            MessageLookupByLibrary.simpleMessage("Report comment"),
        "moderation__report_community_text":
            MessageLookupByLibrary.simpleMessage("Report community"),
        "moderation__report_hashtag_text":
            MessageLookupByLibrary.simpleMessage("Report hashtag"),
        "moderation__report_post_text":
            MessageLookupByLibrary.simpleMessage("Report post"),
        "moderation__reporter_text":
            MessageLookupByLibrary.simpleMessage("Reporter"),
        "moderation__reports_preview_resource_reports":
            MessageLookupByLibrary.simpleMessage("reports"),
        "moderation__reports_preview_title":
            MessageLookupByLibrary.simpleMessage("Reports"),
        "moderation__reports_see_all": m22,
        "moderation__tap_to_retry":
            MessageLookupByLibrary.simpleMessage("Tap to retry loading items"),
        "moderation__update_category_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "moderation__update_category_title":
            MessageLookupByLibrary.simpleMessage("Update category"),
        "moderation__update_description_report_desc":
            MessageLookupByLibrary.simpleMessage("Report description"),
        "moderation__update_description_report_hint_text":
            MessageLookupByLibrary.simpleMessage(
                "e.g. The report item was found to..."),
        "moderation__update_description_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "moderation__update_description_title":
            MessageLookupByLibrary.simpleMessage("Edit description"),
        "moderation__update_status_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "moderation__update_status_title":
            MessageLookupByLibrary.simpleMessage("Update status"),
        "moderation__you_have_reported_account_text":
            MessageLookupByLibrary.simpleMessage(
                "You have reported this account"),
        "moderation__you_have_reported_comment_text":
            MessageLookupByLibrary.simpleMessage(
                "You have reported this comment"),
        "moderation__you_have_reported_community_text":
            MessageLookupByLibrary.simpleMessage(
                "You have reported this community"),
        "moderation__you_have_reported_hashtag_text":
            MessageLookupByLibrary.simpleMessage(
                "You have reported this hashtag"),
        "moderation__you_have_reported_post_text":
            MessageLookupByLibrary.simpleMessage("You have reported this post"),
        "notifications__accepted_connection_request_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] accepted your connection request."),
        "notifications__comment_comment_notification_tile_user_also_commented":
            m23,
        "notifications__comment_comment_notification_tile_user_commented": m24,
        "notifications__comment_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when someone comments on one of your posts or one you also commented"),
        "notifications__comment_reaction_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when someone reacts to one of your post commments"),
        "notifications__comment_reaction_title":
            MessageLookupByLibrary.simpleMessage("Post comment reaction"),
        "notifications__comment_reply_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when someone replies to one of your comments or one you also replied to"),
        "notifications__comment_reply_notification_tile_user_also_replied": m25,
        "notifications__comment_reply_notification_tile_user_replied": m26,
        "notifications__comment_reply_title":
            MessageLookupByLibrary.simpleMessage("Post comment reply"),
        "notifications__comment_title":
            MessageLookupByLibrary.simpleMessage("Post comment"),
        "notifications__comment_user_mention_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when someone mentions you on one of their comments"),
        "notifications__comment_user_mention_title":
            MessageLookupByLibrary.simpleMessage("Post comment mention"),
        "notifications__community_invite_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when someone invites you to join a community"),
        "notifications__community_invite_title":
            MessageLookupByLibrary.simpleMessage("Community invite"),
        "notifications__community_new_post_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when there is a new post in a community you enabled post notifications on"),
        "notifications__community_new_post_tile": m27,
        "notifications__community_new_post_title":
            MessageLookupByLibrary.simpleMessage("Community new post"),
        "notifications__connection_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when someone wants to connect with you"),
        "notifications__connection_request_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] wants to connect with you."),
        "notifications__connection_title":
            MessageLookupByLibrary.simpleMessage("Connection request"),
        "notifications__follow_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when someone starts following you"),
        "notifications__follow_title":
            MessageLookupByLibrary.simpleMessage("Follow"),
        "notifications__following_you_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] is now following you."),
        "notifications__general_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when something happens"),
        "notifications__general_title":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "notifications__mentioned_in_post_comment_tile": m28,
        "notifications__mentioned_in_post_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] mentioned you on a post."),
        "notifications__mute_post_turn_off_post_comment_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Turn off post comment notifications"),
        "notifications__mute_post_turn_off_post_notifications":
            MessageLookupByLibrary.simpleMessage("Turn off post notifications"),
        "notifications__mute_post_turn_on_post_comment_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Turn on post comment notifications"),
        "notifications__mute_post_turn_on_post_notifications":
            MessageLookupByLibrary.simpleMessage("Turn on post notifications"),
        "notifications__post_reaction_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when someone reacts to one of your posts"),
        "notifications__post_reaction_title":
            MessageLookupByLibrary.simpleMessage("Post reaction"),
        "notifications__post_user_mention_desc":
            MessageLookupByLibrary.simpleMessage(
                "Be notified when someone mentions you on one of their posts"),
        "notifications__post_user_mention_title":
            MessageLookupByLibrary.simpleMessage("Post mention"),
        "notifications__reacted_to_post_comment_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] reacted to your post comment."),
        "notifications__reacted_to_post_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] reacted to your post."),
        "notifications__settings_title":
            MessageLookupByLibrary.simpleMessage("Notifications settings"),
        "notifications__tab_general":
            MessageLookupByLibrary.simpleMessage("General"),
        "notifications__tab_requests":
            MessageLookupByLibrary.simpleMessage("Requests"),
        "notifications__user_community_invite_tile": m29,
        "notifications__user_new_post_desc": MessageLookupByLibrary.simpleMessage(
            "Be notified when there is a new post by a user you enabled notifications on"),
        "notifications__user_new_post_tile":
            MessageLookupByLibrary.simpleMessage(
                "[name] [username] posted something."),
        "notifications__user_new_post_title":
            MessageLookupByLibrary.simpleMessage("User new post"),
        "permissions_service__camera_permission_denied":
            MessageLookupByLibrary.simpleMessage(
                "We require the camera permission to allow you to take photos and record videos, please grant it in your settings."),
        "permissions_service__storage_permission_denied":
            MessageLookupByLibrary.simpleMessage(
                "We require the storage permission to allow you to pick media items, please grant it in your settings."),
        "post__action_comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "post__action_react": MessageLookupByLibrary.simpleMessage("React"),
        "post__action_reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "post__actions_comment_deleted":
            MessageLookupByLibrary.simpleMessage("Comment deleted"),
        "post__actions_delete":
            MessageLookupByLibrary.simpleMessage("Delete post"),
        "post__actions_delete_comment":
            MessageLookupByLibrary.simpleMessage("Delete comment"),
        "post__actions_delete_comment_description":
            MessageLookupByLibrary.simpleMessage(
                "The comment, as well as its replies and reactions will be permanently deleted."),
        "post__actions_delete_description": MessageLookupByLibrary.simpleMessage(
            "The post, as well as its comments and reactions will be permanently deleted."),
        "post__actions_deleted":
            MessageLookupByLibrary.simpleMessage("Post deleted"),
        "post__actions_edit_comment":
            MessageLookupByLibrary.simpleMessage("Edit comment"),
        "post__actions_report_text":
            MessageLookupByLibrary.simpleMessage("Report"),
        "post__actions_reported_text":
            MessageLookupByLibrary.simpleMessage("Reported"),
        "post__actions_show_more_text":
            MessageLookupByLibrary.simpleMessage("Show more"),
        "post__close_create_post_label":
            MessageLookupByLibrary.simpleMessage("Close create new post"),
        "post__close_post": MessageLookupByLibrary.simpleMessage("Close post"),
        "post__comment_maxlength_error": m30,
        "post__comment_reply_expanded_post":
            MessageLookupByLibrary.simpleMessage("Post"),
        "post__comment_reply_expanded_reply_comment":
            MessageLookupByLibrary.simpleMessage("Reply to comment"),
        "post__comment_reply_expanded_reply_hint_text":
            MessageLookupByLibrary.simpleMessage("Your reply..."),
        "post__comment_required_error":
            MessageLookupByLibrary.simpleMessage("Comment cannot be empty."),
        "post__commenter_expanded_edit_comment":
            MessageLookupByLibrary.simpleMessage("Edit comment"),
        "post__commenter_expanded_join_conversation":
            MessageLookupByLibrary.simpleMessage("Join the conversation..."),
        "post__commenter_expanded_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "post__commenter_expanded_start_conversation":
            MessageLookupByLibrary.simpleMessage("Start the conversation..."),
        "post__commenter_post_text":
            MessageLookupByLibrary.simpleMessage("Post"),
        "post__commenter_write_something":
            MessageLookupByLibrary.simpleMessage("Write something..."),
        "post__comments_closed_post":
            MessageLookupByLibrary.simpleMessage("Closed post"),
        "post__comments_disabled":
            MessageLookupByLibrary.simpleMessage("Comments disabled"),
        "post__comments_disabled_message":
            MessageLookupByLibrary.simpleMessage("Comments disabled for post"),
        "post__comments_enabled_message":
            MessageLookupByLibrary.simpleMessage("Comments enabled for post"),
        "post__comments_header_be_the_first_comments":
            MessageLookupByLibrary.simpleMessage("Be the first to comment"),
        "post__comments_header_be_the_first_replies":
            MessageLookupByLibrary.simpleMessage("Be the first to reply"),
        "post__comments_header_newer":
            MessageLookupByLibrary.simpleMessage("Newer"),
        "post__comments_header_newest_comments":
            MessageLookupByLibrary.simpleMessage("Newest comments"),
        "post__comments_header_newest_replies":
            MessageLookupByLibrary.simpleMessage("Newest replies"),
        "post__comments_header_older":
            MessageLookupByLibrary.simpleMessage("Older"),
        "post__comments_header_oldest_comments":
            MessageLookupByLibrary.simpleMessage("Oldest comments"),
        "post__comments_header_oldest_replies":
            MessageLookupByLibrary.simpleMessage("Oldest replies"),
        "post__comments_header_see_newest_comments":
            MessageLookupByLibrary.simpleMessage("See newest comments"),
        "post__comments_header_see_newest_replies":
            MessageLookupByLibrary.simpleMessage("See newest replies"),
        "post__comments_header_see_oldest_comments":
            MessageLookupByLibrary.simpleMessage("See oldest comments"),
        "post__comments_header_see_oldest_replies":
            MessageLookupByLibrary.simpleMessage("See oldest replies"),
        "post__comments_header_view_newest_comments":
            MessageLookupByLibrary.simpleMessage("View newest comments"),
        "post__comments_header_view_newest_replies":
            MessageLookupByLibrary.simpleMessage("View newest replies"),
        "post__comments_header_view_oldest_comments":
            MessageLookupByLibrary.simpleMessage("View oldest comments"),
        "post__comments_header_view_oldest_replies":
            MessageLookupByLibrary.simpleMessage("View oldest replies"),
        "post__comments_page_no_more_replies_to_load":
            MessageLookupByLibrary.simpleMessage("No more replies to load"),
        "post__comments_page_no_more_to_load":
            MessageLookupByLibrary.simpleMessage("No more comments to load"),
        "post__comments_page_replies_title":
            MessageLookupByLibrary.simpleMessage("Post replies"),
        "post__comments_page_tap_to_retry":
            MessageLookupByLibrary.simpleMessage(
                "Tap to retry loading comments."),
        "post__comments_page_tap_to_retry_replies":
            MessageLookupByLibrary.simpleMessage(
                "Tap to retry loading replies."),
        "post__comments_page_title":
            MessageLookupByLibrary.simpleMessage("Post comments"),
        "post__comments_view_all_comments": m31,
        "post__create_camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "post__create_hashtags_invalid": m32,
        "post__create_media": MessageLookupByLibrary.simpleMessage("Media"),
        "post__create_new": MessageLookupByLibrary.simpleMessage("New post"),
        "post__create_new_community_post_label":
            MessageLookupByLibrary.simpleMessage("Create new communtiy post"),
        "post__create_new_post_label":
            MessageLookupByLibrary.simpleMessage("Create new post"),
        "post__create_next": MessageLookupByLibrary.simpleMessage("Next"),
        "post__create_photo": MessageLookupByLibrary.simpleMessage("Photo"),
        "post__create_video": MessageLookupByLibrary.simpleMessage("Video"),
        "post__disable_post_comments":
            MessageLookupByLibrary.simpleMessage("Disable post comments"),
        "post__edit_save": MessageLookupByLibrary.simpleMessage("Save"),
        "post__edit_title": MessageLookupByLibrary.simpleMessage("Edit post"),
        "post__enable_post_comments":
            MessageLookupByLibrary.simpleMessage("Enable post comments"),
        "post__exclude_community_from_profile_posts":
            MessageLookupByLibrary.simpleMessage(
                "Hide this community from my profile"),
        "post__exclude_community_from_profile_posts_confirmation":
            MessageLookupByLibrary.simpleMessage(
                "This will hide all posts from this community from your profile."),
        "post__exclude_community_from_profile_posts_success":
            MessageLookupByLibrary.simpleMessage("Community hidden"),
        "post__exclude_post_community": MessageLookupByLibrary.simpleMessage(
            "Don\'t show posts from this community"),
        "post__have_not_shared_anything": MessageLookupByLibrary.simpleMessage(
            "You have not shared anything yet."),
        "post__is_closed": MessageLookupByLibrary.simpleMessage("Closed post"),
        "post__load_more":
            MessageLookupByLibrary.simpleMessage("Load more posts"),
        "post__my_circles": MessageLookupByLibrary.simpleMessage("My circles"),
        "post__my_circles_desc": MessageLookupByLibrary.simpleMessage(
            "Share the post to one or multiple of your circles."),
        "post__no_circles_for": m33,
        "post__open_post": MessageLookupByLibrary.simpleMessage("Open post"),
        "post__post_closed":
            MessageLookupByLibrary.simpleMessage("Post closed "),
        "post__post_opened":
            MessageLookupByLibrary.simpleMessage("Post opened"),
        "post__post_reactions_title":
            MessageLookupByLibrary.simpleMessage("Post reactions"),
        "post__profile_counts_follower":
            MessageLookupByLibrary.simpleMessage(" Follower"),
        "post__profile_counts_followers":
            MessageLookupByLibrary.simpleMessage(" Followers"),
        "post__profile_counts_following":
            MessageLookupByLibrary.simpleMessage(" Following"),
        "post__profile_counts_post":
            MessageLookupByLibrary.simpleMessage(" Post"),
        "post__profile_counts_posts":
            MessageLookupByLibrary.simpleMessage(" Posts"),
        "post__profile_retry_loading_posts":
            MessageLookupByLibrary.simpleMessage("Tap to retry"),
        "post__reaction_list_tap_retry": MessageLookupByLibrary.simpleMessage(
            "Tap to retry loading reactions."),
        "post__search_circles":
            MessageLookupByLibrary.simpleMessage("Search circles..."),
        "post__share": MessageLookupByLibrary.simpleMessage("Share"),
        "post__share_community": MessageLookupByLibrary.simpleMessage("Share"),
        "post__share_community_desc": MessageLookupByLibrary.simpleMessage(
            "Share the post to a community you\'re part of."),
        "post__share_community_title":
            MessageLookupByLibrary.simpleMessage("A community"),
        "post__share_to": MessageLookupByLibrary.simpleMessage("Share to"),
        "post__share_to_circles":
            MessageLookupByLibrary.simpleMessage("Share to circles"),
        "post__share_to_community":
            MessageLookupByLibrary.simpleMessage("Share to community"),
        "post__shared_privately_on":
            MessageLookupByLibrary.simpleMessage("Shared privately on"),
        "post__sharing_post_to":
            MessageLookupByLibrary.simpleMessage("Sharing post to"),
        "post__text_copied":
            MessageLookupByLibrary.simpleMessage("Text copied!"),
        "post__time_short_days": MessageLookupByLibrary.simpleMessage("d"),
        "post__time_short_hours": MessageLookupByLibrary.simpleMessage("h"),
        "post__time_short_minutes": MessageLookupByLibrary.simpleMessage("m"),
        "post__time_short_now_text":
            MessageLookupByLibrary.simpleMessage("now"),
        "post__time_short_one_day": MessageLookupByLibrary.simpleMessage("1d"),
        "post__time_short_one_hour": MessageLookupByLibrary.simpleMessage("1h"),
        "post__time_short_one_minute":
            MessageLookupByLibrary.simpleMessage("1m"),
        "post__time_short_one_week": MessageLookupByLibrary.simpleMessage("1w"),
        "post__time_short_one_year": MessageLookupByLibrary.simpleMessage("1y"),
        "post__time_short_seconds": MessageLookupByLibrary.simpleMessage("s"),
        "post__time_short_weeks": MessageLookupByLibrary.simpleMessage("w"),
        "post__time_short_years": MessageLookupByLibrary.simpleMessage("y"),
        "post__timeline_posts_all_loaded":
            MessageLookupByLibrary.simpleMessage("🎉  All posts loaded"),
        "post__timeline_posts_default_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Try refreshing the timeline."),
        "post__timeline_posts_default_drhoo_title":
            MessageLookupByLibrary.simpleMessage("Something\'s not right."),
        "post__timeline_posts_failed_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Try again in a couple seconds"),
        "post__timeline_posts_failed_drhoo_title":
            MessageLookupByLibrary.simpleMessage(
                "Could not load your timeline."),
        "post__timeline_posts_no_more_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Follow users or join a community to get started!"),
        "post__timeline_posts_refresh_posts":
            MessageLookupByLibrary.simpleMessage("Refresh posts"),
        "post__timeline_posts_refreshing_drhoo_title":
            MessageLookupByLibrary.simpleMessage("Hang in there!"),
        "post__top_posts_title":
            MessageLookupByLibrary.simpleMessage("Explore"),
        "post__trending_posts_load_more":
            MessageLookupByLibrary.simpleMessage("Load older posts"),
        "post__trending_posts_no_trending_posts":
            MessageLookupByLibrary.simpleMessage(
                "There are no trending posts. Try refreshing in a couple seconds."),
        "post__trending_posts_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "post__trending_posts_title":
            MessageLookupByLibrary.simpleMessage("Trending"),
        "post__undo_exclude_post_community":
            MessageLookupByLibrary.simpleMessage(
                "Show posts from this community"),
        "post__user_has_not_shared_anything": m34,
        "post__usernames_circles": m35,
        "post__world_circle_name":
            MessageLookupByLibrary.simpleMessage("World"),
        "post__you_shared_with":
            MessageLookupByLibrary.simpleMessage("You shared with"),
        "post_body_link_preview__empty": MessageLookupByLibrary.simpleMessage(
            "This link could not be previewed"),
        "post_body_link_preview__error_with_description": m36,
        "post_body_link_preview__invalid": m68,
        "post_body_media__unsupported":
            MessageLookupByLibrary.simpleMessage("Unsupported media type"),
        "post_uploader__cancelled":
            MessageLookupByLibrary.simpleMessage("Cancelled!"),
        "post_uploader__cancelling":
            MessageLookupByLibrary.simpleMessage("Cancelling"),
        "post_uploader__compressing_media":
            MessageLookupByLibrary.simpleMessage("Compressing media..."),
        "post_uploader__creating_post":
            MessageLookupByLibrary.simpleMessage("Creating post..."),
        "post_uploader__generic_upload_failed":
            MessageLookupByLibrary.simpleMessage("Upload failed"),
        "post_uploader__processing":
            MessageLookupByLibrary.simpleMessage("Processing post..."),
        "post_uploader__publishing":
            MessageLookupByLibrary.simpleMessage("Publishing post..."),
        "post_uploader__success":
            MessageLookupByLibrary.simpleMessage("Success!"),
        "post_uploader__uploading_media":
            MessageLookupByLibrary.simpleMessage("Uploading media..."),
        "posts_stream__all_loaded":
            MessageLookupByLibrary.simpleMessage("🎉  All posts loaded"),
        "posts_stream__empty_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Try refreshing in a couple of seconds."),
        "posts_stream__empty_drhoo_title":
            MessageLookupByLibrary.simpleMessage("This stream is empty."),
        "posts_stream__failed_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Try again in a couple seconds"),
        "posts_stream__failed_drhoo_title":
            MessageLookupByLibrary.simpleMessage("Could not load the stream."),
        "posts_stream__refreshing_drhoo_subtitle":
            MessageLookupByLibrary.simpleMessage("Refreshing the stream."),
        "posts_stream__refreshing_drhoo_title":
            MessageLookupByLibrary.simpleMessage("Hang in there!"),
        "posts_stream__status_tile_empty":
            MessageLookupByLibrary.simpleMessage("No posts found"),
        "posts_stream__status_tile_no_more_to_load":
            MessageLookupByLibrary.simpleMessage("🎉  All posts loaded"),
        "user__add_account_done": MessageLookupByLibrary.simpleMessage("Done"),
        "user__add_account_save": MessageLookupByLibrary.simpleMessage("Save"),
        "user__add_account_success":
            MessageLookupByLibrary.simpleMessage("Success"),
        "user__add_account_to_lists":
            MessageLookupByLibrary.simpleMessage("Add account to list"),
        "user__add_account_update_account_lists":
            MessageLookupByLibrary.simpleMessage("Update account lists"),
        "user__add_account_update_lists":
            MessageLookupByLibrary.simpleMessage("Update lists"),
        "user__billion_postfix": MessageLookupByLibrary.simpleMessage("b"),
        "user__block_description": MessageLookupByLibrary.simpleMessage(
            "You will both dissapear from each other\'s social network experience, with the exception of organizations which the person is a staff member of."),
        "user__block_user": MessageLookupByLibrary.simpleMessage("Block user"),
        "user__change_email_current_email_text":
            MessageLookupByLibrary.simpleMessage("Current email"),
        "user__change_email_email_text":
            MessageLookupByLibrary.simpleMessage("Email"),
        "user__change_email_error":
            MessageLookupByLibrary.simpleMessage("Email is already registered"),
        "user__change_email_hint_text":
            MessageLookupByLibrary.simpleMessage("Enter your new email"),
        "user__change_email_save": MessageLookupByLibrary.simpleMessage("Save"),
        "user__change_email_success_info": MessageLookupByLibrary.simpleMessage(
            "We\'ve sent a confirmation link to your new email address, click it to verify your new email"),
        "user__change_email_title":
            MessageLookupByLibrary.simpleMessage("Change Email"),
        "user__circle_name_empty_error": MessageLookupByLibrary.simpleMessage(
            "Circle name cannot be empty."),
        "user__circle_name_range_error": m37,
        "user__circle_peoples_count": m38,
        "user__clear_app_preferences_cleared_successfully":
            MessageLookupByLibrary.simpleMessage(
                "Cleared preferences successfully"),
        "user__clear_app_preferences_desc": MessageLookupByLibrary.simpleMessage(
            "Clear the application preferences. Currently this is only the preferred order of comments."),
        "user__clear_app_preferences_error":
            MessageLookupByLibrary.simpleMessage("Could not clear preferences"),
        "user__clear_app_preferences_title":
            MessageLookupByLibrary.simpleMessage("Clear preferences"),
        "user__clear_application_cache_desc":
            MessageLookupByLibrary.simpleMessage(
                "Clear cached posts, accounts, images & more."),
        "user__clear_application_cache_failure":
            MessageLookupByLibrary.simpleMessage("Could not clear cache"),
        "user__clear_application_cache_success":
            MessageLookupByLibrary.simpleMessage("Cleared cache successfully"),
        "user__clear_application_cache_text":
            MessageLookupByLibrary.simpleMessage("Clear cache"),
        "user__confirm_block_user_blocked":
            MessageLookupByLibrary.simpleMessage("User blocked."),
        "user__confirm_block_user_info": MessageLookupByLibrary.simpleMessage(
            "You won\'t see each other posts nor be able to interact in any way."),
        "user__confirm_block_user_no":
            MessageLookupByLibrary.simpleMessage("No"),
        "user__confirm_block_user_question": m39,
        "user__confirm_block_user_title":
            MessageLookupByLibrary.simpleMessage("Confirmation"),
        "user__confirm_block_user_yes":
            MessageLookupByLibrary.simpleMessage("Yes"),
        "user__confirm_connection_add_connection":
            MessageLookupByLibrary.simpleMessage("Add connection to circle"),
        "user__confirm_connection_confirm_text":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "user__confirm_connection_connection_confirmed":
            MessageLookupByLibrary.simpleMessage("Connection confirmed"),
        "user__confirm_connection_with": m40,
        "user__confirm_guidelines_reject_chat_community":
            MessageLookupByLibrary.simpleMessage("Chat with the community."),
        "user__confirm_guidelines_reject_chat_immediately":
            MessageLookupByLibrary.simpleMessage("Start a chat immediately."),
        "user__confirm_guidelines_reject_chat_with_team":
            MessageLookupByLibrary.simpleMessage("Chat with the team."),
        "user__confirm_guidelines_reject_delete_account":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "user__confirm_guidelines_reject_go_back":
            MessageLookupByLibrary.simpleMessage("Go back"),
        "user__confirm_guidelines_reject_info":
            MessageLookupByLibrary.simpleMessage(
                "You can\'t use Okuna until you accept the guidelines."),
        "user__confirm_guidelines_reject_join_slack":
            MessageLookupByLibrary.simpleMessage("Join the Slack channel."),
        "user__confirm_guidelines_reject_title":
            MessageLookupByLibrary.simpleMessage("Guidelines Rejection"),
        "user__connect_to_user_add_connection":
            MessageLookupByLibrary.simpleMessage("Add connection to circle"),
        "user__connect_to_user_connect_with_username": m41,
        "user__connect_to_user_done":
            MessageLookupByLibrary.simpleMessage("Done"),
        "user__connect_to_user_request_sent":
            MessageLookupByLibrary.simpleMessage("Connection request sent"),
        "user__connection_circle_edit":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "user__connection_pending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "user__connections_circle_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "user__connections_header_circle_desc":
            MessageLookupByLibrary.simpleMessage(
                "The circle all of your connections get added to."),
        "user__connections_header_users":
            MessageLookupByLibrary.simpleMessage("Users"),
        "user__delete_account_confirmation_desc":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete your account?"),
        "user__delete_account_confirmation_desc_info":
            MessageLookupByLibrary.simpleMessage(
                "This is a permanent action and can\'t be undone."),
        "user__delete_account_confirmation_goodbye":
            MessageLookupByLibrary.simpleMessage("Goodbye 😢"),
        "user__delete_account_confirmation_no":
            MessageLookupByLibrary.simpleMessage("No"),
        "user__delete_account_confirmation_title":
            MessageLookupByLibrary.simpleMessage("Confirmation"),
        "user__delete_account_confirmation_yes":
            MessageLookupByLibrary.simpleMessage("Yes"),
        "user__delete_account_current_pwd":
            MessageLookupByLibrary.simpleMessage("Current Password"),
        "user__delete_account_current_pwd_hint":
            MessageLookupByLibrary.simpleMessage("Enter your current password"),
        "user__delete_account_next":
            MessageLookupByLibrary.simpleMessage("Next"),
        "user__delete_account_title":
            MessageLookupByLibrary.simpleMessage("Delete account"),
        "user__disable_new_post_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Disable new post notifications"),
        "user__disconnect_from_user": m42,
        "user__disconnect_from_user_success":
            MessageLookupByLibrary.simpleMessage("Disconnected successfully"),
        "user__edit_profile_bio": MessageLookupByLibrary.simpleMessage("Bio"),
        "user__edit_profile_community_posts":
            MessageLookupByLibrary.simpleMessage("Organizations"),
        "user__edit_profile_community_posts_descr":
            MessageLookupByLibrary.simpleMessage("Display in profile"),
        "user__edit_profile_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "user__edit_profile_location":
            MessageLookupByLibrary.simpleMessage("Location"),
        "user__edit_profile_name": MessageLookupByLibrary.simpleMessage("Name"),
        "user__edit_profile_pick_image":
            MessageLookupByLibrary.simpleMessage("Pick image"),
        "user__edit_profile_pick_image_error_too_large": m43,
        "user__edit_profile_save_text":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__edit_profile_url": MessageLookupByLibrary.simpleMessage("Url"),
        "user__edit_profile_user_name_taken": m44,
        "user__edit_profile_username":
            MessageLookupByLibrary.simpleMessage("Username"),
        "user__email_verification_error": MessageLookupByLibrary.simpleMessage(
            "Oops! Your token was not valid or expired, please try again"),
        "user__email_verification_successful":
            MessageLookupByLibrary.simpleMessage(
                "Awesome! Your email is now verified"),
        "user__emoji_field_none_selected":
            MessageLookupByLibrary.simpleMessage("No emoji selected"),
        "user__emoji_search_none_found": m45,
        "user__enable_new_post_notifications":
            MessageLookupByLibrary.simpleMessage(
                "Enable new post notifications"),
        "user__follow_button_follow_back_text":
            MessageLookupByLibrary.simpleMessage("Follow back"),
        "user__follow_button_follow_text":
            MessageLookupByLibrary.simpleMessage("Follow"),
        "user__follow_button_following_text":
            MessageLookupByLibrary.simpleMessage("Following"),
        "user__follow_button_unfollow_text":
            MessageLookupByLibrary.simpleMessage("Unfollow"),
        "user__follow_lists_no_list_found":
            MessageLookupByLibrary.simpleMessage("No lists found."),
        "user__follow_lists_no_list_found_for": m46,
        "user__follow_lists_search_for":
            MessageLookupByLibrary.simpleMessage("Search for a list..."),
        "user__follow_lists_title":
            MessageLookupByLibrary.simpleMessage("My lists"),
        "user__follower_plural":
            MessageLookupByLibrary.simpleMessage("followers"),
        "user__follower_singular":
            MessageLookupByLibrary.simpleMessage("follower"),
        "user__followers_title":
            MessageLookupByLibrary.simpleMessage("Followers"),
        "user__following_resource_name":
            MessageLookupByLibrary.simpleMessage("followed users"),
        "user__following_text":
            MessageLookupByLibrary.simpleMessage("Following"),
        "user__follows_list_accounts_count": m47,
        "user__follows_list_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "user__follows_list_header_title":
            MessageLookupByLibrary.simpleMessage("Users"),
        "user__follows_lists_account":
            MessageLookupByLibrary.simpleMessage("1 Account"),
        "user__follows_lists_accounts": m48,
        "user__groups_see_all": m49,
        "user__guidelines_accept":
            MessageLookupByLibrary.simpleMessage("Accept"),
        "user__guidelines_desc": MessageLookupByLibrary.simpleMessage(
            "Please take a moment to read and accept our guidelines."),
        "user__guidelines_reject":
            MessageLookupByLibrary.simpleMessage("Reject"),
        "user__invite": MessageLookupByLibrary.simpleMessage("Invite"),
        "user__invite_member": MessageLookupByLibrary.simpleMessage("Member"),
        "user__invite_someone_message": m50,
        "user__invites_accepted_group_item_name":
            MessageLookupByLibrary.simpleMessage("accepted invite"),
        "user__invites_accepted_group_name":
            MessageLookupByLibrary.simpleMessage("accepted invites"),
        "user__invites_accepted_title":
            MessageLookupByLibrary.simpleMessage("Accepted"),
        "user__invites_create_create":
            MessageLookupByLibrary.simpleMessage("Create"),
        "user__invites_create_create_title":
            MessageLookupByLibrary.simpleMessage("Create invite"),
        "user__invites_create_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit invite"),
        "user__invites_create_name_hint":
            MessageLookupByLibrary.simpleMessage("e.g. Jane Doe"),
        "user__invites_create_name_title":
            MessageLookupByLibrary.simpleMessage("Nickname"),
        "user__invites_create_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__invites_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "user__invites_edit_text": MessageLookupByLibrary.simpleMessage("Edit"),
        "user__invites_email_hint":
            MessageLookupByLibrary.simpleMessage("e.g. janedoe@email.com"),
        "user__invites_email_invite_text":
            MessageLookupByLibrary.simpleMessage("Email invite"),
        "user__invites_email_send_text":
            MessageLookupByLibrary.simpleMessage("Send"),
        "user__invites_email_sent_text":
            MessageLookupByLibrary.simpleMessage("Invite email sent"),
        "user__invites_email_text":
            MessageLookupByLibrary.simpleMessage("Email"),
        "user__invites_invite_a_friend":
            MessageLookupByLibrary.simpleMessage("Invite a friend"),
        "user__invites_invite_text":
            MessageLookupByLibrary.simpleMessage("Invite"),
        "user__invites_joined_with": m51,
        "user__invites_none_left": MessageLookupByLibrary.simpleMessage(
            "You have no invites available."),
        "user__invites_none_used": MessageLookupByLibrary.simpleMessage(
            "Looks like you haven\'t used any invite."),
        "user__invites_pending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "user__invites_pending_email": m52,
        "user__invites_pending_group_item_name":
            MessageLookupByLibrary.simpleMessage("pending invite"),
        "user__invites_pending_group_name":
            MessageLookupByLibrary.simpleMessage("pending invites"),
        "user__invites_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "user__invites_share_email":
            MessageLookupByLibrary.simpleMessage("Share invite by email"),
        "user__invites_share_email_desc": MessageLookupByLibrary.simpleMessage(
            "We will send an invitation email with instructions on your behalf"),
        "user__invites_share_yourself":
            MessageLookupByLibrary.simpleMessage("Share invite yourself"),
        "user__invites_share_yourself_desc":
            MessageLookupByLibrary.simpleMessage(
                "Choose from messaging apps, etc."),
        "user__invites_title":
            MessageLookupByLibrary.simpleMessage("My invites"),
        "user__language_settings_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__language_settings_saved_success":
            MessageLookupByLibrary.simpleMessage(
                "Language changed successfully"),
        "user__language_settings_title":
            MessageLookupByLibrary.simpleMessage("Language settings"),
        "user__list_name_empty_error":
            MessageLookupByLibrary.simpleMessage("List name cannot be empty."),
        "user__list_name_range_error": m53,
        "user__manage": MessageLookupByLibrary.simpleMessage("Manage"),
        "user__manage_profile_community_posts_toggle":
            MessageLookupByLibrary.simpleMessage("Community posts"),
        "user__manage_profile_community_posts_toggle__descr":
            MessageLookupByLibrary.simpleMessage(
                "Display posts you share with public organizations, on your profile."),
        "user__manage_profile_details_title":
            MessageLookupByLibrary.simpleMessage("Details"),
        "user__manage_profile_details_title_desc":
            MessageLookupByLibrary.simpleMessage(
                "Change your username, name, url, location, avatar or cover photo."),
        "user__manage_profile_followers_count_toggle":
            MessageLookupByLibrary.simpleMessage("Followers count"),
        "user__manage_profile_followers_count_toggle__descr":
            MessageLookupByLibrary.simpleMessage(
                "Display the number of people that follow you, on your profile."),
        "user__manage_profile_title":
            MessageLookupByLibrary.simpleMessage("Manage profile"),
        "user__million_postfix": MessageLookupByLibrary.simpleMessage("m"),
        "user__profile_action_cancel_connection":
            MessageLookupByLibrary.simpleMessage("Cancel connection request"),
        "user__profile_action_deny_connection":
            MessageLookupByLibrary.simpleMessage("Deny connection request"),
        "user__profile_action_user_blocked":
            MessageLookupByLibrary.simpleMessage("User blocked"),
        "user__profile_action_user_post_notifications_disabled":
            MessageLookupByLibrary.simpleMessage(
                "New post notifications disabled"),
        "user__profile_action_user_post_notifications_enabled":
            MessageLookupByLibrary.simpleMessage(
                "New post notifications enabled"),
        "user__profile_action_user_unblocked":
            MessageLookupByLibrary.simpleMessage("User unblocked"),
        "user__profile_bio_length_error": m54,
        "user__profile_in_circles":
            MessageLookupByLibrary.simpleMessage("In circles"),
        "user__profile_location_length_error": m55,
        "user__profile_okuna_age_toast": m56,
        "user__profile_posts_exclude_communities":
            MessageLookupByLibrary.simpleMessage("Exclude organizations"),
        "user__profile_posts_excluded_communities":
            MessageLookupByLibrary.simpleMessage("Hidden organizations"),
        "user__profile_posts_excluded_communities_desc":
            MessageLookupByLibrary.simpleMessage(
                "See, add and remove hidden organizations from your profile."),
        "user__profile_url_invalid_error":
            MessageLookupByLibrary.simpleMessage("Please provide a valid url."),
        "user__remove_account_from_list":
            MessageLookupByLibrary.simpleMessage("Remove account from lists"),
        "user__remove_account_from_list_success":
            MessageLookupByLibrary.simpleMessage("Success"),
        "user__save_connection_circle_color_hint":
            MessageLookupByLibrary.simpleMessage("(Tap to change)"),
        "user__save_connection_circle_color_name":
            MessageLookupByLibrary.simpleMessage("Color"),
        "user__save_connection_circle_create":
            MessageLookupByLibrary.simpleMessage("Create circle"),
        "user__save_connection_circle_edit":
            MessageLookupByLibrary.simpleMessage("Edit circle"),
        "user__save_connection_circle_hint":
            MessageLookupByLibrary.simpleMessage("e.g. Friends, Family, Work."),
        "user__save_connection_circle_name":
            MessageLookupByLibrary.simpleMessage("Name"),
        "user__save_connection_circle_name_taken": m57,
        "user__save_connection_circle_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__save_connection_circle_users":
            MessageLookupByLibrary.simpleMessage("Users"),
        "user__save_follows_list_create":
            MessageLookupByLibrary.simpleMessage("Create list"),
        "user__save_follows_list_edit":
            MessageLookupByLibrary.simpleMessage("Edit list"),
        "user__save_follows_list_emoji":
            MessageLookupByLibrary.simpleMessage("Emoji"),
        "user__save_follows_list_emoji_required_error":
            MessageLookupByLibrary.simpleMessage("Emoji is required"),
        "user__save_follows_list_hint_text":
            MessageLookupByLibrary.simpleMessage("e.g. Travel, Photography"),
        "user__save_follows_list_name":
            MessageLookupByLibrary.simpleMessage("Name"),
        "user__save_follows_list_name_taken": m58,
        "user__save_follows_list_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__save_follows_list_users":
            MessageLookupByLibrary.simpleMessage("Users"),
        "user__thousand_postfix": MessageLookupByLibrary.simpleMessage("k"),
        "user__tile_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "user__tile_following":
            MessageLookupByLibrary.simpleMessage(" · Following"),
        "user__timeline_filters_apply_all":
            MessageLookupByLibrary.simpleMessage("Apply filters"),
        "user__timeline_filters_circles":
            MessageLookupByLibrary.simpleMessage("Circles"),
        "user__timeline_filters_clear_all":
            MessageLookupByLibrary.simpleMessage("Clear all"),
        "user__timeline_filters_lists":
            MessageLookupByLibrary.simpleMessage("Lists"),
        "user__timeline_filters_no_match": m59,
        "user__timeline_filters_search_desc":
            MessageLookupByLibrary.simpleMessage(
                "Search for circles and lists..."),
        "user__timeline_filters_title":
            MessageLookupByLibrary.simpleMessage("Timeline filters"),
        "user__translate_see_translation":
            MessageLookupByLibrary.simpleMessage("See translation"),
        "user__translate_show_original":
            MessageLookupByLibrary.simpleMessage("Show original"),
        "user__unblock_description": MessageLookupByLibrary.simpleMessage(
            "You will both be able to follow, connect or explore each other\'s content again."),
        "user__unblock_user":
            MessageLookupByLibrary.simpleMessage("Unblock user"),
        "user__uninvite": MessageLookupByLibrary.simpleMessage("Uninvite"),
        "user__update_connection_circle_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "user__update_connection_circle_updated":
            MessageLookupByLibrary.simpleMessage("Connection updated"),
        "user__update_connection_circles_title":
            MessageLookupByLibrary.simpleMessage("Update connection circles"),
        "user_search__cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "user_search__communities":
            MessageLookupByLibrary.simpleMessage("organizations"),
        "user_search__hashtags":
            MessageLookupByLibrary.simpleMessage("Hashtags"),
        "user_search__list_no_results_found": m60,
        "user_search__list_refresh_text":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "user_search__list_retry":
            MessageLookupByLibrary.simpleMessage("Tap to retry."),
        "user_search__list_search_text": m61,
        "user_search__no_communities_for": m62,
        "user_search__no_hashtags_for": m63,
        "user_search__no_results_for": m64,
        "user_search__no_users_for": m65,
        "user_search__search_text":
            MessageLookupByLibrary.simpleMessage("Search..."),
        "user_search__searching_for": m66,
        "user_search__selection_clear_all":
            MessageLookupByLibrary.simpleMessage("Clear all"),
        "user_search__selection_submit":
            MessageLookupByLibrary.simpleMessage("Submit"),
        "user_search__users": MessageLookupByLibrary.simpleMessage("Users"),
        "video_picker__from_camera":
            MessageLookupByLibrary.simpleMessage("From camera"),
        "video_picker__from_gallery":
            MessageLookupByLibrary.simpleMessage("From gallery")
      };
}
