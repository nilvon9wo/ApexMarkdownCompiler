public class MKDN_ND_SentenceNode extends MKDN_ND_Node {
    public List<MKDN_ND_Node> wordList {get; private set;}
    
    public MKDN_ND_SentenceNode(List<MKDN_ND_Node> wordList, Integer consumed) {
    	this.wordList = wordList;
    	this.nodeType = MKDN_ND_NodeTypeEnum.SENTENCE;
    	this.consumed = consumed;
    }
}