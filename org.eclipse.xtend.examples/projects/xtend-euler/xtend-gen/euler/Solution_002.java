/**
 * Copyright (c) 2012 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 * 
 * Author - Sebastian Zarnekow
 * See https://github.com/szarnekow/xtend-euler
 */
package euler;

import com.google.common.collect.AbstractIterator;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;

/**
 * Each new term in the Fibonacci sequence is generated by adding the previous two terms.
 * By starting with 1 and 2, the first 10 terms will be:
 * 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
 * 
 * By considering the terms in the Fibonacci sequence whose values do not exceed four million,
 * find the sum of the even-valued terms.
 * 
 * @see http://projecteuler.net/problem=2
 */
@SuppressWarnings("all")
public class Solution_002 extends AbstractIterator<Long> {
  public static void main(final String[] args) {
    final Function2<Long, Long, Long> _function = (Long l1, Long l2) -> {
      return Long.valueOf(((l1).longValue() + (l2).longValue()));
    };
    InputOutput.<Long>println(IteratorExtensions.<Long>reduce(new Solution_002(), _function));
  }

  private long l0 = 0;

  private long l1 = 1;

  @Override
  protected Long computeNext() {
    Long _xblockexpression = null;
    {
      if ((this.l1 > 4000000)) {
        this.endOfData();
      }
      long result = (this.l0 + this.l1);
      this.l0 = this.l1;
      this.l1 = result;
      Long _xifexpression = null;
      if (((result % 2) == 0)) {
        _xifexpression = Long.valueOf(result);
      } else {
        _xifexpression = this.computeNext();
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
}
