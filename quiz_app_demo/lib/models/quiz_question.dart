class QuizQuestion {  //not a widget

  const QuizQuestion(this.text, this.answers);
  
  final String text; //question 
  final List<String> answers; //list of choices for answers

  List<String> getShuffledAnswers() {
    //.shuffle() changes the list in the memory
    //void shuffle
    final shuffledList = List.of(answers);
    //final lists can be changed but cannot be reassigned 
    //such as : shuffledList = ['Hello'];
    shuffledList.shuffle();
    return shuffledList;
  }
}
