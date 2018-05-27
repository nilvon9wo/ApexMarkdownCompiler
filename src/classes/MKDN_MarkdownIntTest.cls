@isTest
public class MKDN_MarkdownIntTest {
	private static final User TEST_USER = TEST_DummyUserFactory.DEFAULT_USER;
	private static final MKDN_Markdown MARKDOWN_UNDER_TEST = MKDN_Markdown.getInstance();
	
    @isTest public static void testMarkdownShouldGenerateHtml() {
    	// Arrange
    	String testInput = '__Foo__ and *text*.\n\nAnother para.';
    	
    	// Act
    	Object result;
    	Test.startTest(); 
    	System.runAs(TEST_USER) {
    		result = MARKDOWN_UNDER_TEST.toHtml(testInput); 
    	}
    	Test.stopTest();	 
    	
    	// Assert
    	System.assertEquals('<p><strong>Foo</strong> and <em>text</em>.</p><p>Another para.</p>', result);
   }
}