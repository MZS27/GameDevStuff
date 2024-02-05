using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class Quiz : MonoBehaviour
{
    [Header("Questions")]
    [SerializeField] TextMeshProUGUI questionText;
    [SerializeField] List<QuestionScriptable> questionsList = new List<QuestionScriptable>();
    QuestionScriptable currentQuestion;
    
    [Header("Options")]
    [SerializeField] GameObject[] optionButtons;
    int answerIndex;
    bool hasAnsweredInTime = true;

    [Header("Button Colors")]
    [SerializeField] Sprite optionSprite;
    [SerializeField] Sprite answerSprite;

    [Header("Timer")]
    [SerializeField] Image timerImage;
    Timer timer;

    [Header("Scoring")]
    [SerializeField] TextMeshProUGUI scoreText;
    ScoreKeeper scoreKeeper;

    [Header("Progress Bar")]
    [SerializeField] Slider progressBar;

    public bool isQuizComplete;

    void Awake()
    {
        timer = FindObjectOfType<Timer>();
        scoreKeeper = FindObjectOfType<ScoreKeeper>();
        progressBar.maxValue = questionsList.Count;
        progressBar.value = 0;
    }

    void Update() 
    {
        timerImage.fillAmount = timer.fillFraction; 
        if(timer.loadNextQuestion)
        {
            if(progressBar.value == progressBar.maxValue)
            {
                isQuizComplete = true;
            }
            hasAnsweredInTime = false;
            GetNextQuestion();
            timer.loadNextQuestion = false;
        }
        else if(!hasAnsweredInTime && !timer.isAnsweringQuestion)
        {
            DisplayAnswer(-1);
        }
    }

    public void OnAnswerSelected(int index)
    {
        hasAnsweredInTime = true;
        DisplayAnswer(index);
        SetButtonState(false);
        timer.CancelTimer();
        scoreText.text = "Score: " + scoreKeeper.CalculateScore() + "%";

        
    }

    public void DisplayAnswer(int index)
    {
        if(index == currentQuestion.GetAnswerIndex())
        {
            questionText.text = "Correct!";
            Image buttonImage = optionButtons[index].GetComponentInParent<Image>();
            buttonImage.sprite = answerSprite;
            scoreKeeper.IncrementCorrectAnswersCount();
        }
        else
        {
            answerIndex = currentQuestion.GetAnswerIndex();
            string answer = currentQuestion.getOptionText(answerIndex);
            questionText.text = "Wrong! The correct answer is:\n" + answer;
            Image buttonImage = optionButtons[answerIndex].GetComponentInParent<Image>();
            buttonImage.sprite = answerSprite;
        }
    }

    void GetNextQuestion()
    {
        if(questionsList.Count > 0)
        {
            QueueNextQuestion();
            //QueueRandomQuestion();
            DisplayQuestion();
            SetButtonState(true);
            SetDefaultButtonSprites();
            progressBar.value++;
            scoreKeeper.IncrementQuestionsSeen();
        }
    }

    void QueueRandomQuestion()
    {
        int index = Random.Range(0,questionsList.Count);
        currentQuestion = questionsList[index];
        questionsList.RemoveAt(index);
    }

    void QueueNextQuestion()
    {
        currentQuestion = questionsList[0];
        questionsList.RemoveAt(0);
    }

    void DisplayQuestion()
    {
        questionText.text = currentQuestion.GetQuestion();

        for(int i=0; i<optionButtons.Length; i++)
        {
            TextMeshProUGUI buttonText = optionButtons[i].GetComponentInChildren<TextMeshProUGUI>();
            buttonText.text = currentQuestion.getOptionText(i);
        }
    }

    void SetButtonState(bool state)
    {
        
        for(int i=0; i<optionButtons.Length; i++)
        {
            Button button = optionButtons[i].GetComponentInChildren<Button>();
            button.interactable = state;
        }
    }

    void SetDefaultButtonSprites()
    {
        for(int i=0; i<optionButtons.Length; i++)
        {
            Image buttonImage = optionButtons[i].GetComponentInParent<Image>();
            buttonImage.sprite = optionSprite;
        }
    }
}
