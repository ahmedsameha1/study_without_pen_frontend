class Old_Field_DBV6_AppV32 {
  // This constant represents the name of the table which contains the data of the names of the fields that the user will create.
  static final String TABLE_NAME = "field";
  // This constant represents the name of the column which will contain the names of the fields that the user will create in the field table.
  static final String COLUMN_FIELD_NAME = "field_name";
  static final String COLUMN_FIELD_TYPE = "field_type";
}

final String COLUMN_ID = "_id";
final String CREATION_DATE = "creation_date";
final String Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 = "created_at";

class Old_Question_DBV6_AppV32 {
  static final String TABLE_NAME = "question";
  static final String COLUMN_QUESTION_ENTRY = "question_entry";
}

class Old_Answer_DBV6_AppV32 {
  static final String TABLE_NAME = "answer";
  static final String COLUMN_ANSWER_ENTRY = "answer_entry";
}

class Old_Linker_DBV6_AppV32 {
  static final String TABLE_NAME = "linker";
  static final String COLUMN_QUESTION_LINK = "question_link";
  static final String COLUMN_ANSWER_LINK = "answer_link";
  static final String COLUMN_FIELD_LINK = "field_link";
  static final String COLUMN_STUDY_DURING_ORDER = "study_during_order";
  static final String COLUMN_TEST_ORDER = "test_order";
  static final String COLUMN_TEST_WRONG_ANSWERS = "test_wrong_answers";
}

class Old_Study_During_Temp_DBV6_AppV32 {
  static final String TABLE_NAME = "study_during_temp_table";
  static final String COLUMN_QUESTION = "question";
  static final String COLUMN_ANSWER = "answer";
  static final String COLUMN_FIELD = "field";
}

class STring {
  static final String TABLE_NAME = "string";
  static final String COLUMN_VALUE = "value";
}

class String_Entry {
  static final String TABLE_NAME = "string_entry";
  static final String COLUMN_QUESTION = "question";
  static final String COLUMN_ANSWER = "answer";
  static final String COLUMN_FIELD = "field";
  static final String COLUMN_PAUSED_ENHANCED_TEST_ORDER =
      "paused_enhanced_test_order";
  static final String COLUMN_PAUSED_FULLY_RANDOM_TEST_ORDER =
      "paused_fully_random_test_order";
  static final String COLUMN_PAUSED_STUDY_PERIOD_ORDER =
      "paused_study_period_order";
  static final String COLUMN_PAUSED_STUDY_AGAIN_ENHANCED_TEST_ORDER =
      "paused_study_again_enhanced_test_order";
  static final String COLUMN_PAUSED_STUDY_AGAIN_FULLY_RANDOM_TEST_ORDER =
      "paused_study_again_fully_random_test_order";
  static final String COLUMN_ASKED_COUNT = "asked_count";
  static final String COLUMN_WRONGLY_ANSWERED_COUNT = "wrongly_answered_count";
  static final String COLUMN_RANK = "rank";
  static final String COLUMN_CREATION_EMULATED_DATE = "creation_emulated_date";
  static final String COLUMN_REMIND_AT = "remind_at";
  static final String COLUMN_REMIND_AT_PENDINGINTENT_REQUEST =
      "remind_at_pendingintent_request";
  static final String COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND =
      "whether_asked_at_current_test_round";
  static final String COLUMN_ORDER_OF_ENTRY = "order_of_entry";
}

class Constants {
  static final int NOT_EMULATED = 0;
}

abstract class TestRound {
  static final int ASKED_AT_CURRENT_ROUND = 1;
  static final int DID_NOT_ASKED_AT_CURRENT_ROUND = 0;
}

abstract class TimeOfAnswer {
  static final int NOTIFY = 0;
}

abstract class Old_Study_Period_Repeated_Entry_DBV12_AppV68 {
  static final String TABLE_NAME = "study_period_repeated_entry";
  static final String COLUMN_FIELD = "field";
  static final String COLUMN_REPEATED_ENTRY = "repeated_entry";
}

abstract class FField {
  static final int DO_NOT_READ_ANSWER = 0;
  static final int DO_NOT_IGNORE_CASE = 3;
  static final int ZERO_RANDOM_QUICK_TESTS = 0;
  static final String TABLE_NAME = "field";
  static final String COLUMN_FIELD_NAME = "name";
  static final String COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE = "string_or_blob";
  static final String COLUMN_LOCALE = "locale";
  static final String COLUMN_SORT_BY = "sort_by";
  static final String COLUMN_COLOR = "color";
  static final String COLUMN_LIST_TEXT_SIZE = "list_text_size";
  static final String COLUMN_QUESTION_AREA_SIZE = "question_area_size";
  static final String COLUMN_ANSWER_AREA_SIZE = "answer_area_size";
  static final String COLUMN_TEST_TEXT_SIZE = "test_text_size";
  static final String COLUMN_ACTION_BAR_SHOWN = "action_bar_shown";
  static final String COLUMN_READ_ANSWER = "read_answer";
  static final String COLUMN_USAGE_COUNT = "usage_count";
  static final String COLUMN_CREATION_EMULATION_NUMBER =
      "creation_emulation_number";
  static final String COLUMN_CREATION_EMULATION_WHAT_DAYS =
      "creation_emulation_what_days";
  static final String COLUMN_CHECK_TYPE = "check_type";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES =
      "random_quick_test_number_of_tries";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS =
      "random_quick_test_number_of_questions";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS =
      "random_quick_test_number_of_tests";
  static final String COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL =
      "random_quick_test_wrongness_level";
  static final String COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL =
      "random_quick_test_rank_level";
  static final String COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION =
      "random_quick_test_controlled_portion";
  static final String COLUMN_READING_QUESTION_LETTER_SECOND_TESTS =
      "reading_question_letter_second_tests";
  static final String COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS =
      "typing_answer_letter_second_tests";
  static final String COLUMN_FIND_ANSWER_TIME_TESTS = "find_answer_time_tests";
  static final String COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT =
      "reading_question_letter_second_study_till_correct";
  static final String COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT =
      "typing_answer_letter_second_study_till_correct";
  static final String COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT =
      "find_answer_time_study_till_correct";
  static final String COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT =
      "time_of_answer_tests_do_what";
  static final String COLUMN_OBFUSCATE_QUESTION = "obfuscate_question";
}

abstract class Old_Study_Period_Paused_DBV12_AppV68 {
  static final String TABLE_NAME = "study_period_paused";
}

abstract class Old_Field_DBV12_AppV68 {
  static final String TABLE_NAME = "field";
  static final String COLUMN_FIELD_NAME = "name";
  static final String COLUMN_FIELD_TYPE = "type";
  static final String COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE = "string_or_blob";
  static final String COLUMN_LOCALE = "locale";
  static final String COLUMN_SORT_BY = "sort_by";
  static final String COLUMN_LIST_TEXT_SIZE = "list_text_size";
  static final String COLUMN_QUESTION_AREA_SIZE = "question_area_size";
  static final String COLUMN_ANSWER_AREA_SIZE = "answer_area_size";
  static final String COLUMN_TEST_TEXT_SIZE = "test_text_size";
  static final String COLUMN_ACTION_BAR_SHOWN = "action_bar_shown";
  static final String COLUMN_READ_ANSWER = "read_answer";
  static final String COLUMN_USAGE_COUNT = "usage_count";
  static final String COLUMN_CREATION_EMULATION_NUMBER =
      "creation_emulation_number";
  static final String COLUMN_CHECK_TYPE = "check_type";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES =
      "random_quick_test_number_of_tries";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS =
      "random_quick_test_number_of_questions";
  static final String COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS =
      "random_quick_test_number_of_tests";
  static final String COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL =
      "random_quick_test_wrongness_level";
  static final String COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL =
      "random_quick_test_rank_level";
  static final String COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION =
      "random_quick_test_controlled_portion";
  static final String COLUMN_READING_QUESTION_LETTER_SECOND_TESTS =
      "reading_question_letter_second_tests";
  static final String COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS =
      "typing_answer_letter_second_tests";
  static final String COLUMN_FIND_ANSWER_TIME_TESTS = "find_answer_time_tests";
  static final String COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT =
      "reading_question_letter_second_study_till_correct";
  static final String COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT =
      "typing_answer_letter_second_study_till_correct";
  static final String COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT =
      "find_answer_time_study_till_correct";
  static final String COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT =
      "time_of_answer_tests_do_what";
  static final String COLUMN_OBFUSCATE_QUESTION = "obfuscate_question";
}

abstract class Old_String_Entry {
  static final String TABLE_NAME = "string_entry";
  static final String COLUMN_QUESTION = "question";
  static final String COLUMN_ANSWER = "answer";
  static final String COLUMN_FIELD = "field";
  static final String COLUMN_PAUSED_TEST_ORDER = "paused_test_order";
  static final String COLUMN_PAUSED_STUDY_PERIOD_ORDER =
      "paused_study_period_order";
  static final String COLUMN_ASKED_COUNT = "asked_count";
  static final String COLUMN_WRONGLY_ANSWERED_COUNT = "wrongly_answered_count";
  static final String COLUMN_RANK = "rank";
  static final String COLUMN_CREATION_EMULATED_DATE = "creation_emulated_date";
  static final String COLUMN_REMIND_AT = "remind_at";
  static final String COLUMN_REMIND_AT_PENDINGINTENT_REQUEST =
      "remind_at_pendingintent_request";
  static final String COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND =
      "whether_asked_at_current_test_round";
  static final String COLUMN_ORDER_OF_ENTRY = "order_of_entry";
}

abstract class Field_Note {
  static final String TABLE_NAME = "field_note";
  static final String COLUMN_FIELD = "field";
  static final String COLUMN_NOTE = "note";
}
