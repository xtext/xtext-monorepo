package org.eclipse.xtext.ui.tests.editor.contentassist.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

@SuppressWarnings("all")
public class InternalBug332217TestLanguageLexer extends Lexer {
    public static final int T__19=19;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int T__17=17;
    public static final int T__18=18;
    public static final int T__11=11;
    public static final int T__12=12;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int RULE_ID=4;
    public static final int T__26=26;
    public static final int T__27=27;
    public static final int T__28=28;
    public static final int RULE_INT=6;
    public static final int T__29=29;
    public static final int T__22=22;
    public static final int RULE_ML_COMMENT=7;
    public static final int T__23=23;
    public static final int T__24=24;
    public static final int T__25=25;
    public static final int T__20=20;
    public static final int T__21=21;
    public static final int RULE_STRING=5;
    public static final int RULE_SL_COMMENT=8;
    public static final int T__37=37;
    public static final int T__38=38;
    public static final int T__39=39;
    public static final int T__33=33;
    public static final int T__34=34;
    public static final int T__35=35;
    public static final int T__36=36;
    public static final int EOF=-1;
    public static final int T__30=30;
    public static final int T__31=31;
    public static final int T__32=32;
    public static final int RULE_WS=9;
    public static final int RULE_ANY_OTHER=10;
    public static final int T__44=44;
    public static final int T__45=45;
    public static final int T__46=46;
    public static final int T__47=47;
    public static final int T__40=40;
    public static final int T__41=41;
    public static final int T__42=42;
    public static final int T__43=43;

    // delegates
    // delegators

    public InternalBug332217TestLanguageLexer() {;} 
    public InternalBug332217TestLanguageLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public InternalBug332217TestLanguageLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "InternalBug332217TestLanguage.g"; }

    // $ANTLR start "T__11"
    public final void mT__11() throws RecognitionException {
        try {
            int _type = T__11;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:11:7: ( '[]' )
            // InternalBug332217TestLanguage.g:11:9: '[]'
            {
            match("[]"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__11"

    // $ANTLR start "T__12"
    public final void mT__12() throws RecognitionException {
        try {
            int _type = T__12;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:12:7: ( '.' )
            // InternalBug332217TestLanguage.g:12:9: '.'
            {
            match('.'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__12"

    // $ANTLR start "T__13"
    public final void mT__13() throws RecognitionException {
        try {
            int _type = T__13;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:13:7: ( '(' )
            // InternalBug332217TestLanguage.g:13:9: '('
            {
            match('('); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__13"

    // $ANTLR start "T__14"
    public final void mT__14() throws RecognitionException {
        try {
            int _type = T__14;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:14:7: ( ')' )
            // InternalBug332217TestLanguage.g:14:9: ')'
            {
            match(')'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__14"

    // $ANTLR start "T__15"
    public final void mT__15() throws RecognitionException {
        try {
            int _type = T__15;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:15:7: ( 'replace(' )
            // InternalBug332217TestLanguage.g:15:9: 'replace('
            {
            match("replace("); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__15"

    // $ANTLR start "T__16"
    public final void mT__16() throws RecognitionException {
        try {
            int _type = T__16;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:16:7: ( ',' )
            // InternalBug332217TestLanguage.g:16:9: ','
            {
            match(','); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__16"

    // $ANTLR start "T__17"
    public final void mT__17() throws RecognitionException {
        try {
            int _type = T__17;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:17:7: ( 'urlconform(' )
            // InternalBug332217TestLanguage.g:17:9: 'urlconform('
            {
            match("urlconform("); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__17"

    // $ANTLR start "T__18"
    public final void mT__18() throws RecognitionException {
        try {
            int _type = T__18;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:18:7: ( '[' )
            // InternalBug332217TestLanguage.g:18:9: '['
            {
            match('['); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__18"

    // $ANTLR start "T__19"
    public final void mT__19() throws RecognitionException {
        try {
            int _type = T__19;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:19:7: ( ']' )
            // InternalBug332217TestLanguage.g:19:9: ']'
            {
            match(']'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__19"

    // $ANTLR start "T__20"
    public final void mT__20() throws RecognitionException {
        try {
            int _type = T__20;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:20:7: ( 'split(' )
            // InternalBug332217TestLanguage.g:20:9: 'split('
            {
            match("split("); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__20"

    // $ANTLR start "T__21"
    public final void mT__21() throws RecognitionException {
        try {
            int _type = T__21;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:21:7: ( 'tableview' )
            // InternalBug332217TestLanguage.g:21:9: 'tableview'
            {
            match("tableview"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__21"

    // $ANTLR start "T__22"
    public final void mT__22() throws RecognitionException {
        try {
            int _type = T__22;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:22:7: ( '{' )
            // InternalBug332217TestLanguage.g:22:9: '{'
            {
            match('{'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__22"

    // $ANTLR start "T__23"
    public final void mT__23() throws RecognitionException {
        try {
            int _type = T__23;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:23:7: ( 'title:' )
            // InternalBug332217TestLanguage.g:23:9: 'title:'
            {
            match("title:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__23"

    // $ANTLR start "T__24"
    public final void mT__24() throws RecognitionException {
        try {
            int _type = T__24;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:24:7: ( 'titleImage:' )
            // InternalBug332217TestLanguage.g:24:9: 'titleImage:'
            {
            match("titleImage:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__24"

    // $ANTLR start "T__25"
    public final void mT__25() throws RecognitionException {
        try {
            int _type = T__25;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:25:7: ( 'style:' )
            // InternalBug332217TestLanguage.g:25:9: 'style:'
            {
            match("style:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__25"

    // $ANTLR start "T__26"
    public final void mT__26() throws RecognitionException {
        try {
            int _type = T__26;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:26:7: ( '}' )
            // InternalBug332217TestLanguage.g:26:9: '}'
            {
            match('}'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__26"

    // $ANTLR start "T__27"
    public final void mT__27() throws RecognitionException {
        try {
            int _type = T__27;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:27:7: ( 'section' )
            // InternalBug332217TestLanguage.g:27:9: 'section'
            {
            match("section"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__27"

    // $ANTLR start "T__28"
    public final void mT__28() throws RecognitionException {
        try {
            int _type = T__28;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:28:7: ( 'cell' )
            // InternalBug332217TestLanguage.g:28:9: 'cell'
            {
            match("cell"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__28"

    // $ANTLR start "T__29"
    public final void mT__29() throws RecognitionException {
        try {
            int _type = T__29;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:29:7: ( 'text:' )
            // InternalBug332217TestLanguage.g:29:9: 'text:'
            {
            match("text:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__29"

    // $ANTLR start "T__30"
    public final void mT__30() throws RecognitionException {
        try {
            int _type = T__30;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:30:7: ( 'details:' )
            // InternalBug332217TestLanguage.g:30:9: 'details:'
            {
            match("details:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__30"

    // $ANTLR start "T__31"
    public final void mT__31() throws RecognitionException {
        try {
            int _type = T__31;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:31:7: ( 'image:' )
            // InternalBug332217TestLanguage.g:31:9: 'image:'
            {
            match("image:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__31"

    // $ANTLR start "T__32"
    public final void mT__32() throws RecognitionException {
        try {
            int _type = T__32;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:32:7: ( 'action:' )
            // InternalBug332217TestLanguage.g:32:9: 'action:'
            {
            match("action:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__32"

    // $ANTLR start "T__33"
    public final void mT__33() throws RecognitionException {
        try {
            int _type = T__33;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:33:7: ( 'accessory:' )
            // InternalBug332217TestLanguage.g:33:9: 'accessory:'
            {
            match("accessory:"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__33"

    // $ANTLR start "T__34"
    public final void mT__34() throws RecognitionException {
        try {
            int _type = T__34;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:34:7: ( 'for' )
            // InternalBug332217TestLanguage.g:34:9: 'for'
            {
            match("for"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__34"

    // $ANTLR start "T__35"
    public final void mT__35() throws RecognitionException {
        try {
            int _type = T__35;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:35:7: ( 'in' )
            // InternalBug332217TestLanguage.g:35:9: 'in'
            {
            match("in"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__35"

    // $ANTLR start "T__36"
    public final void mT__36() throws RecognitionException {
        try {
            int _type = T__36;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:36:7: ( ':' )
            // InternalBug332217TestLanguage.g:36:9: ':'
            {
            match(':'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__36"

    // $ANTLR start "T__37"
    public final void mT__37() throws RecognitionException {
        try {
            int _type = T__37;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:37:7: ( '@selector' )
            // InternalBug332217TestLanguage.g:37:9: '@selector'
            {
            match("@selector"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__37"

    // $ANTLR start "T__38"
    public final void mT__38() throws RecognitionException {
        try {
            int _type = T__38;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:38:7: ( 'Plain' )
            // InternalBug332217TestLanguage.g:38:9: 'Plain'
            {
            match("Plain"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__38"

    // $ANTLR start "T__39"
    public final void mT__39() throws RecognitionException {
        try {
            int _type = T__39;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:39:7: ( 'Grouped' )
            // InternalBug332217TestLanguage.g:39:9: 'Grouped'
            {
            match("Grouped"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__39"

    // $ANTLR start "T__40"
    public final void mT__40() throws RecognitionException {
        try {
            int _type = T__40;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:40:7: ( 'Default' )
            // InternalBug332217TestLanguage.g:40:9: 'Default'
            {
            match("Default"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__40"

    // $ANTLR start "T__41"
    public final void mT__41() throws RecognitionException {
        try {
            int _type = T__41;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:41:7: ( 'Value1' )
            // InternalBug332217TestLanguage.g:41:9: 'Value1'
            {
            match("Value1"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__41"

    // $ANTLR start "T__42"
    public final void mT__42() throws RecognitionException {
        try {
            int _type = T__42;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:42:7: ( 'Value2' )
            // InternalBug332217TestLanguage.g:42:9: 'Value2'
            {
            match("Value2"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__42"

    // $ANTLR start "T__43"
    public final void mT__43() throws RecognitionException {
        try {
            int _type = T__43;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:43:7: ( 'Subtitle' )
            // InternalBug332217TestLanguage.g:43:9: 'Subtitle'
            {
            match("Subtitle"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__43"

    // $ANTLR start "T__44"
    public final void mT__44() throws RecognitionException {
        try {
            int _type = T__44;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:44:7: ( 'None' )
            // InternalBug332217TestLanguage.g:44:9: 'None'
            {
            match("None"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__44"

    // $ANTLR start "T__45"
    public final void mT__45() throws RecognitionException {
        try {
            int _type = T__45;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:45:7: ( 'Link' )
            // InternalBug332217TestLanguage.g:45:9: 'Link'
            {
            match("Link"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__45"

    // $ANTLR start "T__46"
    public final void mT__46() throws RecognitionException {
        try {
            int _type = T__46;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:46:7: ( 'Detail' )
            // InternalBug332217TestLanguage.g:46:9: 'Detail'
            {
            match("Detail"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__46"

    // $ANTLR start "T__47"
    public final void mT__47() throws RecognitionException {
        try {
            int _type = T__47;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:47:7: ( 'Check' )
            // InternalBug332217TestLanguage.g:47:9: 'Check'
            {
            match("Check"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__47"

    // $ANTLR start "RULE_ID"
    public final void mRULE_ID() throws RecognitionException {
        try {
            int _type = RULE_ID;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1696:9: ( ( '^' )? ( 'a' .. 'z' | 'A' .. 'Z' | '_' ) ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '0' .. '9' )* )
            // InternalBug332217TestLanguage.g:1696:11: ( '^' )? ( 'a' .. 'z' | 'A' .. 'Z' | '_' ) ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '0' .. '9' )*
            {
            // InternalBug332217TestLanguage.g:1696:11: ( '^' )?
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( (LA1_0=='^') ) {
                alt1=1;
            }
            switch (alt1) {
                case 1 :
                    // InternalBug332217TestLanguage.g:1696:11: '^'
                    {
                    match('^'); 

                    }
                    break;

            }

            if ( (input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
                input.consume();

            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            // InternalBug332217TestLanguage.g:1696:40: ( 'a' .. 'z' | 'A' .. 'Z' | '_' | '0' .. '9' )*
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( ((LA2_0>='0' && LA2_0<='9')||(LA2_0>='A' && LA2_0<='Z')||LA2_0=='_'||(LA2_0>='a' && LA2_0<='z')) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // InternalBug332217TestLanguage.g:
            	    {
            	    if ( (input.LA(1)>='0' && input.LA(1)<='9')||(input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_ID"

    // $ANTLR start "RULE_INT"
    public final void mRULE_INT() throws RecognitionException {
        try {
            int _type = RULE_INT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1698:10: ( ( '0' .. '9' )+ )
            // InternalBug332217TestLanguage.g:1698:12: ( '0' .. '9' )+
            {
            // InternalBug332217TestLanguage.g:1698:12: ( '0' .. '9' )+
            int cnt3=0;
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( ((LA3_0>='0' && LA3_0<='9')) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // InternalBug332217TestLanguage.g:1698:13: '0' .. '9'
            	    {
            	    matchRange('0','9'); 

            	    }
            	    break;

            	default :
            	    if ( cnt3 >= 1 ) break loop3;
                        EarlyExitException eee =
                            new EarlyExitException(3, input);
                        throw eee;
                }
                cnt3++;
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_INT"

    // $ANTLR start "RULE_STRING"
    public final void mRULE_STRING() throws RecognitionException {
        try {
            int _type = RULE_STRING;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1700:13: ( ( '\"' ( '\\\\' . | ~ ( ( '\\\\' | '\"' ) ) )* '\"' | '\\'' ( '\\\\' . | ~ ( ( '\\\\' | '\\'' ) ) )* '\\'' ) )
            // InternalBug332217TestLanguage.g:1700:15: ( '\"' ( '\\\\' . | ~ ( ( '\\\\' | '\"' ) ) )* '\"' | '\\'' ( '\\\\' . | ~ ( ( '\\\\' | '\\'' ) ) )* '\\'' )
            {
            // InternalBug332217TestLanguage.g:1700:15: ( '\"' ( '\\\\' . | ~ ( ( '\\\\' | '\"' ) ) )* '\"' | '\\'' ( '\\\\' . | ~ ( ( '\\\\' | '\\'' ) ) )* '\\'' )
            int alt6=2;
            int LA6_0 = input.LA(1);

            if ( (LA6_0=='\"') ) {
                alt6=1;
            }
            else if ( (LA6_0=='\'') ) {
                alt6=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 6, 0, input);

                throw nvae;
            }
            switch (alt6) {
                case 1 :
                    // InternalBug332217TestLanguage.g:1700:16: '\"' ( '\\\\' . | ~ ( ( '\\\\' | '\"' ) ) )* '\"'
                    {
                    match('\"'); 
                    // InternalBug332217TestLanguage.g:1700:20: ( '\\\\' . | ~ ( ( '\\\\' | '\"' ) ) )*
                    loop4:
                    do {
                        int alt4=3;
                        int LA4_0 = input.LA(1);

                        if ( (LA4_0=='\\') ) {
                            alt4=1;
                        }
                        else if ( ((LA4_0>='\u0000' && LA4_0<='!')||(LA4_0>='#' && LA4_0<='[')||(LA4_0>=']' && LA4_0<='\uFFFF')) ) {
                            alt4=2;
                        }


                        switch (alt4) {
                    	case 1 :
                    	    // InternalBug332217TestLanguage.g:1700:21: '\\\\' .
                    	    {
                    	    match('\\'); 
                    	    matchAny(); 

                    	    }
                    	    break;
                    	case 2 :
                    	    // InternalBug332217TestLanguage.g:1700:28: ~ ( ( '\\\\' | '\"' ) )
                    	    {
                    	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='!')||(input.LA(1)>='#' && input.LA(1)<='[')||(input.LA(1)>=']' && input.LA(1)<='\uFFFF') ) {
                    	        input.consume();

                    	    }
                    	    else {
                    	        MismatchedSetException mse = new MismatchedSetException(null,input);
                    	        recover(mse);
                    	        throw mse;}


                    	    }
                    	    break;

                    	default :
                    	    break loop4;
                        }
                    } while (true);

                    match('\"'); 

                    }
                    break;
                case 2 :
                    // InternalBug332217TestLanguage.g:1700:48: '\\'' ( '\\\\' . | ~ ( ( '\\\\' | '\\'' ) ) )* '\\''
                    {
                    match('\''); 
                    // InternalBug332217TestLanguage.g:1700:53: ( '\\\\' . | ~ ( ( '\\\\' | '\\'' ) ) )*
                    loop5:
                    do {
                        int alt5=3;
                        int LA5_0 = input.LA(1);

                        if ( (LA5_0=='\\') ) {
                            alt5=1;
                        }
                        else if ( ((LA5_0>='\u0000' && LA5_0<='&')||(LA5_0>='(' && LA5_0<='[')||(LA5_0>=']' && LA5_0<='\uFFFF')) ) {
                            alt5=2;
                        }


                        switch (alt5) {
                    	case 1 :
                    	    // InternalBug332217TestLanguage.g:1700:54: '\\\\' .
                    	    {
                    	    match('\\'); 
                    	    matchAny(); 

                    	    }
                    	    break;
                    	case 2 :
                    	    // InternalBug332217TestLanguage.g:1700:61: ~ ( ( '\\\\' | '\\'' ) )
                    	    {
                    	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='&')||(input.LA(1)>='(' && input.LA(1)<='[')||(input.LA(1)>=']' && input.LA(1)<='\uFFFF') ) {
                    	        input.consume();

                    	    }
                    	    else {
                    	        MismatchedSetException mse = new MismatchedSetException(null,input);
                    	        recover(mse);
                    	        throw mse;}


                    	    }
                    	    break;

                    	default :
                    	    break loop5;
                        }
                    } while (true);

                    match('\''); 

                    }
                    break;

            }


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_STRING"

    // $ANTLR start "RULE_ML_COMMENT"
    public final void mRULE_ML_COMMENT() throws RecognitionException {
        try {
            int _type = RULE_ML_COMMENT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1702:17: ( '/*' ( options {greedy=false; } : . )* '*/' )
            // InternalBug332217TestLanguage.g:1702:19: '/*' ( options {greedy=false; } : . )* '*/'
            {
            match("/*"); 

            // InternalBug332217TestLanguage.g:1702:24: ( options {greedy=false; } : . )*
            loop7:
            do {
                int alt7=2;
                int LA7_0 = input.LA(1);

                if ( (LA7_0=='*') ) {
                    int LA7_1 = input.LA(2);

                    if ( (LA7_1=='/') ) {
                        alt7=2;
                    }
                    else if ( ((LA7_1>='\u0000' && LA7_1<='.')||(LA7_1>='0' && LA7_1<='\uFFFF')) ) {
                        alt7=1;
                    }


                }
                else if ( ((LA7_0>='\u0000' && LA7_0<=')')||(LA7_0>='+' && LA7_0<='\uFFFF')) ) {
                    alt7=1;
                }


                switch (alt7) {
            	case 1 :
            	    // InternalBug332217TestLanguage.g:1702:52: .
            	    {
            	    matchAny(); 

            	    }
            	    break;

            	default :
            	    break loop7;
                }
            } while (true);

            match("*/"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_ML_COMMENT"

    // $ANTLR start "RULE_SL_COMMENT"
    public final void mRULE_SL_COMMENT() throws RecognitionException {
        try {
            int _type = RULE_SL_COMMENT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1704:17: ( '//' (~ ( ( '\\n' | '\\r' ) ) )* ( ( '\\r' )? '\\n' )? )
            // InternalBug332217TestLanguage.g:1704:19: '//' (~ ( ( '\\n' | '\\r' ) ) )* ( ( '\\r' )? '\\n' )?
            {
            match("//"); 

            // InternalBug332217TestLanguage.g:1704:24: (~ ( ( '\\n' | '\\r' ) ) )*
            loop8:
            do {
                int alt8=2;
                int LA8_0 = input.LA(1);

                if ( ((LA8_0>='\u0000' && LA8_0<='\t')||(LA8_0>='\u000B' && LA8_0<='\f')||(LA8_0>='\u000E' && LA8_0<='\uFFFF')) ) {
                    alt8=1;
                }


                switch (alt8) {
            	case 1 :
            	    // InternalBug332217TestLanguage.g:1704:24: ~ ( ( '\\n' | '\\r' ) )
            	    {
            	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='\t')||(input.LA(1)>='\u000B' && input.LA(1)<='\f')||(input.LA(1)>='\u000E' && input.LA(1)<='\uFFFF') ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    break loop8;
                }
            } while (true);

            // InternalBug332217TestLanguage.g:1704:40: ( ( '\\r' )? '\\n' )?
            int alt10=2;
            int LA10_0 = input.LA(1);

            if ( (LA10_0=='\n'||LA10_0=='\r') ) {
                alt10=1;
            }
            switch (alt10) {
                case 1 :
                    // InternalBug332217TestLanguage.g:1704:41: ( '\\r' )? '\\n'
                    {
                    // InternalBug332217TestLanguage.g:1704:41: ( '\\r' )?
                    int alt9=2;
                    int LA9_0 = input.LA(1);

                    if ( (LA9_0=='\r') ) {
                        alt9=1;
                    }
                    switch (alt9) {
                        case 1 :
                            // InternalBug332217TestLanguage.g:1704:41: '\\r'
                            {
                            match('\r'); 

                            }
                            break;

                    }

                    match('\n'); 

                    }
                    break;

            }


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_SL_COMMENT"

    // $ANTLR start "RULE_WS"
    public final void mRULE_WS() throws RecognitionException {
        try {
            int _type = RULE_WS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1706:9: ( ( ' ' | '\\t' | '\\r' | '\\n' )+ )
            // InternalBug332217TestLanguage.g:1706:11: ( ' ' | '\\t' | '\\r' | '\\n' )+
            {
            // InternalBug332217TestLanguage.g:1706:11: ( ' ' | '\\t' | '\\r' | '\\n' )+
            int cnt11=0;
            loop11:
            do {
                int alt11=2;
                int LA11_0 = input.LA(1);

                if ( ((LA11_0>='\t' && LA11_0<='\n')||LA11_0=='\r'||LA11_0==' ') ) {
                    alt11=1;
                }


                switch (alt11) {
            	case 1 :
            	    // InternalBug332217TestLanguage.g:
            	    {
            	    if ( (input.LA(1)>='\t' && input.LA(1)<='\n')||input.LA(1)=='\r'||input.LA(1)==' ' ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    if ( cnt11 >= 1 ) break loop11;
                        EarlyExitException eee =
                            new EarlyExitException(11, input);
                        throw eee;
                }
                cnt11++;
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_WS"

    // $ANTLR start "RULE_ANY_OTHER"
    public final void mRULE_ANY_OTHER() throws RecognitionException {
        try {
            int _type = RULE_ANY_OTHER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // InternalBug332217TestLanguage.g:1708:16: ( . )
            // InternalBug332217TestLanguage.g:1708:18: .
            {
            matchAny(); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RULE_ANY_OTHER"

    public void mTokens() throws RecognitionException {
        // InternalBug332217TestLanguage.g:1:8: ( T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | T__39 | T__40 | T__41 | T__42 | T__43 | T__44 | T__45 | T__46 | T__47 | RULE_ID | RULE_INT | RULE_STRING | RULE_ML_COMMENT | RULE_SL_COMMENT | RULE_WS | RULE_ANY_OTHER )
        int alt12=44;
        alt12 = dfa12.predict(input);
        switch (alt12) {
            case 1 :
                // InternalBug332217TestLanguage.g:1:10: T__11
                {
                mT__11(); 

                }
                break;
            case 2 :
                // InternalBug332217TestLanguage.g:1:16: T__12
                {
                mT__12(); 

                }
                break;
            case 3 :
                // InternalBug332217TestLanguage.g:1:22: T__13
                {
                mT__13(); 

                }
                break;
            case 4 :
                // InternalBug332217TestLanguage.g:1:28: T__14
                {
                mT__14(); 

                }
                break;
            case 5 :
                // InternalBug332217TestLanguage.g:1:34: T__15
                {
                mT__15(); 

                }
                break;
            case 6 :
                // InternalBug332217TestLanguage.g:1:40: T__16
                {
                mT__16(); 

                }
                break;
            case 7 :
                // InternalBug332217TestLanguage.g:1:46: T__17
                {
                mT__17(); 

                }
                break;
            case 8 :
                // InternalBug332217TestLanguage.g:1:52: T__18
                {
                mT__18(); 

                }
                break;
            case 9 :
                // InternalBug332217TestLanguage.g:1:58: T__19
                {
                mT__19(); 

                }
                break;
            case 10 :
                // InternalBug332217TestLanguage.g:1:64: T__20
                {
                mT__20(); 

                }
                break;
            case 11 :
                // InternalBug332217TestLanguage.g:1:70: T__21
                {
                mT__21(); 

                }
                break;
            case 12 :
                // InternalBug332217TestLanguage.g:1:76: T__22
                {
                mT__22(); 

                }
                break;
            case 13 :
                // InternalBug332217TestLanguage.g:1:82: T__23
                {
                mT__23(); 

                }
                break;
            case 14 :
                // InternalBug332217TestLanguage.g:1:88: T__24
                {
                mT__24(); 

                }
                break;
            case 15 :
                // InternalBug332217TestLanguage.g:1:94: T__25
                {
                mT__25(); 

                }
                break;
            case 16 :
                // InternalBug332217TestLanguage.g:1:100: T__26
                {
                mT__26(); 

                }
                break;
            case 17 :
                // InternalBug332217TestLanguage.g:1:106: T__27
                {
                mT__27(); 

                }
                break;
            case 18 :
                // InternalBug332217TestLanguage.g:1:112: T__28
                {
                mT__28(); 

                }
                break;
            case 19 :
                // InternalBug332217TestLanguage.g:1:118: T__29
                {
                mT__29(); 

                }
                break;
            case 20 :
                // InternalBug332217TestLanguage.g:1:124: T__30
                {
                mT__30(); 

                }
                break;
            case 21 :
                // InternalBug332217TestLanguage.g:1:130: T__31
                {
                mT__31(); 

                }
                break;
            case 22 :
                // InternalBug332217TestLanguage.g:1:136: T__32
                {
                mT__32(); 

                }
                break;
            case 23 :
                // InternalBug332217TestLanguage.g:1:142: T__33
                {
                mT__33(); 

                }
                break;
            case 24 :
                // InternalBug332217TestLanguage.g:1:148: T__34
                {
                mT__34(); 

                }
                break;
            case 25 :
                // InternalBug332217TestLanguage.g:1:154: T__35
                {
                mT__35(); 

                }
                break;
            case 26 :
                // InternalBug332217TestLanguage.g:1:160: T__36
                {
                mT__36(); 

                }
                break;
            case 27 :
                // InternalBug332217TestLanguage.g:1:166: T__37
                {
                mT__37(); 

                }
                break;
            case 28 :
                // InternalBug332217TestLanguage.g:1:172: T__38
                {
                mT__38(); 

                }
                break;
            case 29 :
                // InternalBug332217TestLanguage.g:1:178: T__39
                {
                mT__39(); 

                }
                break;
            case 30 :
                // InternalBug332217TestLanguage.g:1:184: T__40
                {
                mT__40(); 

                }
                break;
            case 31 :
                // InternalBug332217TestLanguage.g:1:190: T__41
                {
                mT__41(); 

                }
                break;
            case 32 :
                // InternalBug332217TestLanguage.g:1:196: T__42
                {
                mT__42(); 

                }
                break;
            case 33 :
                // InternalBug332217TestLanguage.g:1:202: T__43
                {
                mT__43(); 

                }
                break;
            case 34 :
                // InternalBug332217TestLanguage.g:1:208: T__44
                {
                mT__44(); 

                }
                break;
            case 35 :
                // InternalBug332217TestLanguage.g:1:214: T__45
                {
                mT__45(); 

                }
                break;
            case 36 :
                // InternalBug332217TestLanguage.g:1:220: T__46
                {
                mT__46(); 

                }
                break;
            case 37 :
                // InternalBug332217TestLanguage.g:1:226: T__47
                {
                mT__47(); 

                }
                break;
            case 38 :
                // InternalBug332217TestLanguage.g:1:232: RULE_ID
                {
                mRULE_ID(); 

                }
                break;
            case 39 :
                // InternalBug332217TestLanguage.g:1:240: RULE_INT
                {
                mRULE_INT(); 

                }
                break;
            case 40 :
                // InternalBug332217TestLanguage.g:1:249: RULE_STRING
                {
                mRULE_STRING(); 

                }
                break;
            case 41 :
                // InternalBug332217TestLanguage.g:1:261: RULE_ML_COMMENT
                {
                mRULE_ML_COMMENT(); 

                }
                break;
            case 42 :
                // InternalBug332217TestLanguage.g:1:277: RULE_SL_COMMENT
                {
                mRULE_SL_COMMENT(); 

                }
                break;
            case 43 :
                // InternalBug332217TestLanguage.g:1:293: RULE_WS
                {
                mRULE_WS(); 

                }
                break;
            case 44 :
                // InternalBug332217TestLanguage.g:1:301: RULE_ANY_OTHER
                {
                mRULE_ANY_OTHER(); 

                }
                break;

        }

    }


    protected DFA12 dfa12 = new DFA12(this);
    static final String DFA12_eotS =
        "\1\uffff\1\45\3\uffff\1\52\1\uffff\1\52\1\uffff\2\52\2\uffff\5\52\1\uffff\1\43\10\52\1\43\2\uffff\3\43\7\uffff\1\52\2\uffff\1\52\1\uffff\6\52\2\uffff\3\52\1\126\2\52\2\uffff\10\52\5\uffff\13\52\1\uffff\2\52\1\160\21\52\1\u0082\4\52\1\uffff\6\52\1\u008d\1\u008e\10\52\2\uffff\4\52\1\u009c\5\52\2\uffff\1\u00a3\2\52\2\uffff\2\52\1\uffff\2\52\1\uffff\2\52\1\uffff\2\52\1\u00ae\1\u00af\1\u00b0\1\52\1\uffff\2\52\1\u00b4\3\52\1\uffff\1\52\1\u00b9\1\u00ba\3\uffff\1\52\1\uffff\1\52\1\uffff\2\52\1\uffff\1\52\2\uffff\1\u00c0\1\52\1\u00c2\2\52\1\uffff\1\52\1\uffff\1\52\3\uffff";
    static final String DFA12_eofS =
        "\u00c7\uffff";
    static final String DFA12_minS =
        "\1\0\1\135\3\uffff\1\145\1\uffff\1\162\1\uffff\1\145\1\141\2\uffff\2\145\1\155\1\143\1\157\1\uffff\1\163\1\154\1\162\1\145\1\141\1\165\1\157\1\151\1\150\1\101\2\uffff\2\0\1\52\7\uffff\1\160\2\uffff\1\154\1\uffff\1\154\1\171\1\143\1\142\1\164\1\170\2\uffff\1\154\1\164\1\141\1\60\1\143\1\162\2\uffff\1\141\1\157\1\146\1\154\1\142\2\156\1\145\5\uffff\1\154\1\143\1\151\1\154\1\164\2\154\1\164\1\154\1\141\1\147\1\uffff\1\151\1\145\1\60\1\151\1\165\2\141\1\165\1\164\1\145\1\153\1\143\1\141\1\157\1\164\1\145\1\151\2\145\1\72\1\60\1\151\1\145\1\157\1\163\1\uffff\1\156\1\160\1\165\1\151\1\145\1\151\2\60\1\153\1\143\1\156\1\50\1\72\1\157\1\166\1\72\2\uffff\1\154\1\72\1\156\1\163\1\60\1\145\2\154\1\61\1\164\2\uffff\1\60\1\145\1\146\2\uffff\1\156\1\151\1\uffff\1\155\1\163\1\uffff\1\72\1\157\1\uffff\1\144\1\164\3\60\1\154\1\uffff\1\50\1\157\1\60\1\145\1\141\1\72\1\uffff\1\162\2\60\3\uffff\1\145\1\uffff\1\162\1\uffff\1\167\1\147\1\uffff\1\171\2\uffff\1\60\1\155\1\60\1\145\1\72\1\uffff\1\50\1\uffff\1\72\3\uffff";
    static final String DFA12_maxS =
        "\1\uffff\1\135\3\uffff\1\145\1\uffff\1\162\1\uffff\1\164\1\151\2\uffff\2\145\1\156\1\143\1\157\1\uffff\1\163\1\154\1\162\1\145\1\141\1\165\1\157\1\151\1\150\1\172\2\uffff\2\uffff\1\57\7\uffff\1\160\2\uffff\1\154\1\uffff\1\154\1\171\1\143\1\142\1\164\1\170\2\uffff\1\154\1\164\1\141\1\172\1\164\1\162\2\uffff\1\141\1\157\1\164\1\154\1\142\2\156\1\145\5\uffff\1\154\1\143\1\151\1\154\1\164\2\154\1\164\1\154\1\141\1\147\1\uffff\1\151\1\145\1\172\1\151\1\165\2\141\1\165\1\164\1\145\1\153\1\143\1\141\1\157\1\164\1\145\1\151\2\145\1\72\1\172\1\151\1\145\1\157\1\163\1\uffff\1\156\1\160\1\165\1\151\1\145\1\151\2\172\1\153\1\143\1\156\1\50\1\72\1\157\1\166\1\111\2\uffff\1\154\1\72\1\156\1\163\1\172\1\145\2\154\1\62\1\164\2\uffff\1\172\1\145\1\146\2\uffff\1\156\1\151\1\uffff\1\155\1\163\1\uffff\1\72\1\157\1\uffff\1\144\1\164\3\172\1\154\1\uffff\1\50\1\157\1\172\1\145\1\141\1\72\1\uffff\1\162\2\172\3\uffff\1\145\1\uffff\1\162\1\uffff\1\167\1\147\1\uffff\1\171\2\uffff\1\172\1\155\1\172\1\145\1\72\1\uffff\1\50\1\uffff\1\72\3\uffff";
    static final String DFA12_acceptS =
        "\2\uffff\1\2\1\3\1\4\1\uffff\1\6\1\uffff\1\11\2\uffff\1\14\1\20\5\uffff\1\32\12\uffff\1\46\1\47\3\uffff\1\53\1\54\1\1\1\10\1\2\1\3\1\4\1\uffff\1\46\1\6\1\uffff\1\11\6\uffff\1\14\1\20\6\uffff\1\32\1\33\10\uffff\1\47\1\50\1\51\1\52\1\53\13\uffff\1\31\31\uffff\1\30\20\uffff\1\23\1\22\12\uffff\1\42\1\43\3\uffff\1\12\1\17\2\uffff\1\15\2\uffff\1\25\2\uffff\1\34\6\uffff\1\45\6\uffff\1\26\3\uffff\1\44\1\37\1\40\1\uffff\1\5\1\uffff\1\21\2\uffff\1\24\1\uffff\1\35\1\36\5\uffff\1\41\1\uffff\1\13\1\uffff\1\27\1\7\1\16";
    static final String DFA12_specialS =
        "\1\2\36\uffff\1\0\1\1\u00a6\uffff}>";
    static final String[] DFA12_transitionS = DFA12_transitionS_.DFA12_transitionS;
    private static final class DFA12_transitionS_ {
        static final String[] DFA12_transitionS = {
                "\11\43\2\42\2\43\1\42\22\43\1\42\1\43\1\37\4\43\1\40\1\3\1\4\2\43\1\6\1\43\1\2\1\41\12\36\1\22\5\43\1\23\2\35\1\33\1\26\2\35\1\25\4\35\1\32\1\35\1\31\1\35\1\24\2\35\1\30\2\35\1\27\4\35\1\1\1\43\1\10\1\34\1\35\1\43\1\20\1\35\1\15\1\16\1\35\1\21\2\35\1\17\10\35\1\5\1\11\1\12\1\7\5\35\1\13\1\43\1\14\uff82\43",
                "\1\44",
                "",
                "",
                "",
                "\1\51",
                "",
                "\1\54",
                "",
                "\1\60\12\uffff\1\56\3\uffff\1\57",
                "\1\61\3\uffff\1\63\3\uffff\1\62",
                "",
                "",
                "\1\66",
                "\1\67",
                "\1\70\1\71",
                "\1\72",
                "\1\73",
                "",
                "\1\75",
                "\1\76",
                "\1\77",
                "\1\100",
                "\1\101",
                "\1\102",
                "\1\103",
                "\1\104",
                "\1\105",
                "\32\52\4\uffff\1\52\1\uffff\32\52",
                "",
                "",
                "\0\107",
                "\0\107",
                "\1\110\4\uffff\1\111",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "\1\113",
                "",
                "",
                "\1\114",
                "",
                "\1\115",
                "\1\116",
                "\1\117",
                "\1\120",
                "\1\121",
                "\1\122",
                "",
                "",
                "\1\123",
                "\1\124",
                "\1\125",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\130\20\uffff\1\127",
                "\1\131",
                "",
                "",
                "\1\132",
                "\1\133",
                "\1\134\15\uffff\1\135",
                "\1\136",
                "\1\137",
                "\1\140",
                "\1\141",
                "\1\142",
                "",
                "",
                "",
                "",
                "",
                "\1\143",
                "\1\144",
                "\1\145",
                "\1\146",
                "\1\147",
                "\1\150",
                "\1\151",
                "\1\152",
                "\1\153",
                "\1\154",
                "\1\155",
                "",
                "\1\156",
                "\1\157",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\161",
                "\1\162",
                "\1\163",
                "\1\164",
                "\1\165",
                "\1\166",
                "\1\167",
                "\1\170",
                "\1\171",
                "\1\172",
                "\1\173",
                "\1\174",
                "\1\175",
                "\1\176",
                "\1\177",
                "\1\u0080",
                "\1\u0081",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u0083",
                "\1\u0084",
                "\1\u0085",
                "\1\u0086",
                "",
                "\1\u0087",
                "\1\u0088",
                "\1\u0089",
                "\1\u008a",
                "\1\u008b",
                "\1\u008c",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u008f",
                "\1\u0090",
                "\1\u0091",
                "\1\u0092",
                "\1\u0093",
                "\1\u0094",
                "\1\u0095",
                "\1\u0096\16\uffff\1\u0097",
                "",
                "",
                "\1\u0098",
                "\1\u0099",
                "\1\u009a",
                "\1\u009b",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u009d",
                "\1\u009e",
                "\1\u009f",
                "\1\u00a0\1\u00a1",
                "\1\u00a2",
                "",
                "",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u00a4",
                "\1\u00a5",
                "",
                "",
                "\1\u00a6",
                "\1\u00a7",
                "",
                "\1\u00a8",
                "\1\u00a9",
                "",
                "\1\u00aa",
                "\1\u00ab",
                "",
                "\1\u00ac",
                "\1\u00ad",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u00b1",
                "",
                "\1\u00b2",
                "\1\u00b3",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u00b5",
                "\1\u00b6",
                "\1\u00b7",
                "",
                "\1\u00b8",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "",
                "",
                "",
                "\1\u00bb",
                "",
                "\1\u00bc",
                "",
                "\1\u00bd",
                "\1\u00be",
                "",
                "\1\u00bf",
                "",
                "",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u00c1",
                "\12\52\7\uffff\32\52\4\uffff\1\52\1\uffff\32\52",
                "\1\u00c3",
                "\1\u00c4",
                "",
                "\1\u00c5",
                "",
                "\1\u00c6",
                "",
                "",
                ""
        };
    }

    static final short[] DFA12_eot = DFA.unpackEncodedString(DFA12_eotS);
    static final short[] DFA12_eof = DFA.unpackEncodedString(DFA12_eofS);
    static final char[] DFA12_min = DFA.unpackEncodedStringToUnsignedChars(DFA12_minS);
    static final char[] DFA12_max = DFA.unpackEncodedStringToUnsignedChars(DFA12_maxS);
    static final short[] DFA12_accept = DFA.unpackEncodedString(DFA12_acceptS);
    static final short[] DFA12_special = DFA.unpackEncodedString(DFA12_specialS);
    static final short[][] DFA12_transition;

    static {
        int numStates = DFA12_transitionS.length;
        DFA12_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA12_transition[i] = DFA.unpackEncodedString(DFA12_transitionS[i]);
        }
    }

    static class DFA12 extends DFA {

        public DFA12(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 12;
            this.eot = DFA12_eot;
            this.eof = DFA12_eof;
            this.min = DFA12_min;
            this.max = DFA12_max;
            this.accept = DFA12_accept;
            this.special = DFA12_special;
            this.transition = DFA12_transition;
        }
        public String getDescription() {
            return "1:1: Tokens : ( T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | T__39 | T__40 | T__41 | T__42 | T__43 | T__44 | T__45 | T__46 | T__47 | RULE_ID | RULE_INT | RULE_STRING | RULE_ML_COMMENT | RULE_SL_COMMENT | RULE_WS | RULE_ANY_OTHER );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            IntStream input = _input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA12_31 = input.LA(1);

                        s = -1;
                        if ( ((LA12_31>='\u0000' && LA12_31<='\uFFFF')) ) {s = 71;}

                        else s = 35;

                        if ( s>=0 ) return s;
                        break;
                    case 1 : 
                        int LA12_32 = input.LA(1);

                        s = -1;
                        if ( ((LA12_32>='\u0000' && LA12_32<='\uFFFF')) ) {s = 71;}

                        else s = 35;

                        if ( s>=0 ) return s;
                        break;
                    case 2 : 
                        int LA12_0 = input.LA(1);

                        s = -1;
                        if ( (LA12_0=='[') ) {s = 1;}

                        else if ( (LA12_0=='.') ) {s = 2;}

                        else if ( (LA12_0=='(') ) {s = 3;}

                        else if ( (LA12_0==')') ) {s = 4;}

                        else if ( (LA12_0=='r') ) {s = 5;}

                        else if ( (LA12_0==',') ) {s = 6;}

                        else if ( (LA12_0=='u') ) {s = 7;}

                        else if ( (LA12_0==']') ) {s = 8;}

                        else if ( (LA12_0=='s') ) {s = 9;}

                        else if ( (LA12_0=='t') ) {s = 10;}

                        else if ( (LA12_0=='{') ) {s = 11;}

                        else if ( (LA12_0=='}') ) {s = 12;}

                        else if ( (LA12_0=='c') ) {s = 13;}

                        else if ( (LA12_0=='d') ) {s = 14;}

                        else if ( (LA12_0=='i') ) {s = 15;}

                        else if ( (LA12_0=='a') ) {s = 16;}

                        else if ( (LA12_0=='f') ) {s = 17;}

                        else if ( (LA12_0==':') ) {s = 18;}

                        else if ( (LA12_0=='@') ) {s = 19;}

                        else if ( (LA12_0=='P') ) {s = 20;}

                        else if ( (LA12_0=='G') ) {s = 21;}

                        else if ( (LA12_0=='D') ) {s = 22;}

                        else if ( (LA12_0=='V') ) {s = 23;}

                        else if ( (LA12_0=='S') ) {s = 24;}

                        else if ( (LA12_0=='N') ) {s = 25;}

                        else if ( (LA12_0=='L') ) {s = 26;}

                        else if ( (LA12_0=='C') ) {s = 27;}

                        else if ( (LA12_0=='^') ) {s = 28;}

                        else if ( ((LA12_0>='A' && LA12_0<='B')||(LA12_0>='E' && LA12_0<='F')||(LA12_0>='H' && LA12_0<='K')||LA12_0=='M'||LA12_0=='O'||(LA12_0>='Q' && LA12_0<='R')||(LA12_0>='T' && LA12_0<='U')||(LA12_0>='W' && LA12_0<='Z')||LA12_0=='_'||LA12_0=='b'||LA12_0=='e'||(LA12_0>='g' && LA12_0<='h')||(LA12_0>='j' && LA12_0<='q')||(LA12_0>='v' && LA12_0<='z')) ) {s = 29;}

                        else if ( ((LA12_0>='0' && LA12_0<='9')) ) {s = 30;}

                        else if ( (LA12_0=='\"') ) {s = 31;}

                        else if ( (LA12_0=='\'') ) {s = 32;}

                        else if ( (LA12_0=='/') ) {s = 33;}

                        else if ( ((LA12_0>='\t' && LA12_0<='\n')||LA12_0=='\r'||LA12_0==' ') ) {s = 34;}

                        else if ( ((LA12_0>='\u0000' && LA12_0<='\b')||(LA12_0>='\u000B' && LA12_0<='\f')||(LA12_0>='\u000E' && LA12_0<='\u001F')||LA12_0=='!'||(LA12_0>='#' && LA12_0<='&')||(LA12_0>='*' && LA12_0<='+')||LA12_0=='-'||(LA12_0>=';' && LA12_0<='?')||LA12_0=='\\'||LA12_0=='`'||LA12_0=='|'||(LA12_0>='~' && LA12_0<='\uFFFF')) ) {s = 35;}

                        if ( s>=0 ) return s;
                        break;
            }
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 12, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

}