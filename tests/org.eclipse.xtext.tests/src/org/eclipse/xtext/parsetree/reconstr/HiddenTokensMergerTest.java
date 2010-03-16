package org.eclipse.xtext.parsetree.reconstr;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.junit.AbstractXtextTests;
import org.eclipse.xtext.parsetree.reconstr.SerializerUtil.SerializationOptions;
import org.eclipse.xtext.parsetree.reconstr.hiddentokenmergertest.Commentable;
import org.eclipse.xtext.parsetree.reconstr.hiddentokenmergertest.CommentableItem;
import org.eclipse.xtext.parsetree.reconstr.hiddentokenmergertest.HiddentokenmergertestFactory;
import org.eclipse.xtext.parsetree.reconstr.hiddentokenmergertest.RefList;
import org.eclipse.xtext.parsetree.reconstr.hiddentokenmergertest.ValueList;

public class HiddenTokensMergerTest extends AbstractXtextTests {

	@Override
	protected void setUp() throws Exception {
		super.setUp();
		with(HiddenTokensMergerTestLanguageStandaloneSetup.class);
	}

	private void assertRoundtrip(String model) throws Exception {
		EObject o = getModel(model);
		//System.out.println(EmfFormatter.objToStr(((XtextResource) o.eResource()).getParseResult().getRootNode()));
		SerializerUtil.SerializationOptions opt = new SerializerUtil.SerializationOptions();
		opt.setFormat(false);
//		System.out.println(EmfFormatter.objToStr(((XtextResource) o.eResource()).getParseResult().getRootNode()));
		String r = getSerializer().serialize(o, opt);
		assertEquals(model, r);
	}

	public void testDatatypeBug286557a() throws Exception {
		assertRoundtrip("#1 a;");
	}

	public void testDatatypeBug286557b() throws Exception {
		assertRoundtrip("#1 a ref a;");
	}

	public void testDatatypeBug286557c() throws Exception {
		assertRoundtrip("#1 a.b.c;");
	}

	public void testDatatypeBug286557d() throws Exception {
		assertRoundtrip("#1 a.b.c ref a.b.c;");
	}

	public void testEnumBug() throws Exception {
		assertRoundtrip("#2  kw1   array     test");
	}

	public void testCommentable1() throws Exception {
		Commentable model = (Commentable) getModel("#3\n /*a*/ item a\n /*b*/ item b\n /*c*/item c");
		model.getItem().move(1, 2);
		assertEquals("#3\n /*a*/ item a /*c*/item c /*b*/ item b", serialize(model));
	}

	public void testCommentable2() throws Exception {
		Commentable model = (Commentable) getModel("#3 /*a*/ item a /*b*/ item b /*c*/item c");
		model.getItem().move(1, 2);
		assertEquals("#3 /*a*/ item a /*c*/item c /*b*/ item b", serialize(model));
	}

	public void testCommentable3() throws Exception {
		Commentable model = (Commentable) getModel("#3 item a//a\n item b//b\n item c//c\n");
		model.getItem().move(1, 2);
		assertEquals("#3 item a//a\n item c//c\n item b//b\n", serialize(model));
	}

	public void testCommentable4() throws Exception {
		Commentable model = (Commentable) getModel("#3 /*a*/ item a /*b*/ item b /*c*/item c");
		model.getItem().remove(1);
		CommentableItem i = HiddentokenmergertestFactory.eINSTANCE.createCommentableItem();
		i.setId("foo");
		model.getItem().add(i);
		assertEquals("#3 /*a*/ item a /*c*/item c item foo", serialize(model));
	}

	public void testValueList1() throws Exception {
		ValueList model = (ValueList) getModel("#4 a. /* ab */ b c./*cd*/d e.  /*ef*/f.g /*hi*/ .i");
		model.getIds().move(1, 2);
		assertEquals("#4 a. /* ab */ b e.  /*ef*/f.g /*hi*/ .i c./*cd*/d", serialize(model));
	}
	
	public void testRefList2() throws Exception {
		RefList model = (RefList) getModel("#5 a. b c.d e.f.g.i refs a./* ab */ b c./*cd*/  d e.  /*ef*/f.g/*hi*/.i");
		model.getRefs().move(1, 2);
		assertEquals("#5 a. b c.d e.f.g.i refs a./* ab */ b e.  /*ef*/f.g/*hi*/.i c./*cd*/  d", serialize(model));
	}

	@Override
	public String serialize(EObject obj) {
		SerializationOptions opt = new SerializationOptions();
		opt.setFormat(false);
		opt.setValidateConcreteSyntax(true);
		return getSerializer().serialize(obj, opt);
	}

}
